import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bluetooth_print_plus/bluetooth_print_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:go_router/go_router.dart';

import '../cubit/cart_cubit.dart';
import '../models/item_model.dart';

class Print extends StatefulWidget {
  const Print({super.key});

  @override
  State<Print> createState() => _PrintState();
}

class _PrintState extends State<Print> {
  BluetoothDevice? _device;
  List<BluetoothDevice> _scanResults = [];
  late StreamSubscription<List<BluetoothDevice>> _scanResultsSubscription;
  bool _isScanning = false;
  bool _scanTimeout = false;

  @override
  void initState() {
    super.initState();
    initBluetoothPrintPlusListen();
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    super.dispose();
  }

  Future<void> initBluetoothPrintPlusListen() async {
    _scanResultsSubscription = BluetoothPrintPlus.scanResults.listen((event) {
      setState(() {
        _scanResults = event;
      });
    });
  }

  Future<void> onScanPressed() async {
    if (_isScanning) return;

    setState(() {
      _isScanning = true;
      _scanTimeout = false;
    });

    try {
      await BluetoothPrintPlus.startScan(timeout: const Duration(seconds: 20));
      await Future.delayed(const Duration(seconds: 20));

      if (_scanResults.isEmpty) {
        setState(() {
          _scanTimeout = true;
        });
      }
    } catch (e) {
      print("Scan failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to start scanning: $e')),
      );
    }
  }

  Future<void> onStopPressed() async {
    if (!_isScanning) return;

    try {
      await BluetoothPrintPlus.stopScan();
      setState(() {
        _isScanning = false;
      });
    } catch (e) {
      print("Stop scan failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to stop scanning: $e')),
      );
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await BluetoothPrintPlus.connect(device);
      setState(() {
        _device = device;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connected to ${device.name}')),
      );
    } catch (e) {
      print("Connection failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect: $e')),
      );
    }
  }

  String createSeparatorLine(int length) {
    return '-' * length;
  }

  Future<void> printReceipt(List<Item> cartItems, double totalPrice) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    if (_device == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No device connected')),
      );
      return;
    }

    try {
      List<int> bytes = [];

      bytes += generator.text('Adnan Shop',
          styles: const PosStyles(align: PosAlign.center, bold: true));
      bytes += generator.text('Jl. Sunan Gresik 3, Bekasi',
          styles: const PosStyles(align: PosAlign.center));
      bytes += generator.text('0815-2962-0220',
          styles: const PosStyles(align: PosAlign.center));
      bytes += generator.text(createSeparatorLine(46));

      String dateTime = DateTime.now().toString();
      bytes += generator.text(dateTime,
          styles: const PosStyles(align: PosAlign.center));

      bytes += generator.text(createSeparatorLine(46));
      for (var item in cartItems) {
        bytes += generator.text(item.name);
        String itemLine =
            '${item.quantity}x \$${item.price.toStringAsFixed(2)}';
        String totalItem =
            '\$${(item.price * item.quantity).toStringAsFixed(2)}';

        bytes += generator.row([
          PosColumn(text: itemLine, width: 9),
          PosColumn(
              text: totalItem,
              width: 3,
              styles: const PosStyles(align: PosAlign.right)),
        ]);
      }

      int kmebali = 0;
      bytes += generator.text(createSeparatorLine(46));
      String subTotal1 = 'Subtotal:';
      String subTotal2 = '\$${totalPrice.toStringAsFixed(2)}';

      String total1 = 'Total:';
      String total2 = '\$${totalPrice.toStringAsFixed(2)}';
      String pay1 = 'Paid (Cash):';
      String pay2 = '\$${totalPrice.toStringAsFixed(2)}';

      String change1 = 'Change:';
      String change2 = '\$$kmebali';
      bytes += generator.row([
        PosColumn(text: subTotal1, width: 9),
        PosColumn(
            text: subTotal2,
            width: 3,
            styles: const PosStyles(align: PosAlign.right)),
      ]);
      bytes += generator.row([
        PosColumn(text: total1, width: 9),
        PosColumn(
            text: total2,
            width: 3,
            styles: const PosStyles(align: PosAlign.right)),
      ]);
      bytes += generator.row([
        PosColumn(text: pay1, width: 9),
        PosColumn(
            text: pay2,
            width: 3,
            styles: const PosStyles(align: PosAlign.right)),
      ]);
      bytes += generator.row([
        PosColumn(text: change1, width: 9),
        PosColumn(
            text: change2,
            width: 3,
            styles: const PosStyles(align: PosAlign.right)),
      ]);

      bytes += generator.text(createSeparatorLine(46));
      bytes += generator.feed(1);
      bytes += generator.text('Thank you for visiting!',
          styles: const PosStyles(align: PosAlign.center));
      bytes += generator.text('Feedback Link: adnan.com/f/748488',
          styles: const PosStyles(align: PosAlign.center));
      bytes += generator.feed(2);
      bytes += generator.cut();

      await BluetoothPrintPlus.write(Uint8List.fromList(bytes));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Receipt Printed Successfully')),
      );
    } on PlatformException catch (e) {
      print('Print failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to print receipt')),
      );
    }
  }

  Widget buildScanButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: _isScanning ? onStopPressed : onScanPressed,
      backgroundColor: _isScanning ? Colors.red : Colors.green,
      child:
          _isScanning ? const CircularProgressIndicator() : const Text("SCAN"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.go('/order'),
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Bluetooth POS Printer')),
      body: SafeArea(
        child: BluetoothPrintPlus.isBlueOn
            ? BlocBuilder<CartCubit, List<Item>>(
                builder: (context, cartItems) {
                  double totalPrice = 0.0;
                  for (var item in cartItems) {
                    totalPrice += item.totalPrice;
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: _scanResults.map((device) {
                            return ListTile(
                              title: Text(device.name),
                              subtitle: Text(device.address),
                              trailing: OutlinedButton(
                                onPressed: () => connectToDevice(device),
                                child: const Text("Connect"),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      if (_device != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () =>
                                printReceipt(cartItems, totalPrice),
                            child: const Text("Print Receipt"),
                          ),
                        ),
                      if (_scanTimeout)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'No devices found. Please try again.',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                },
              )
            : const Center(
                child: Text(
                  "Bluetooth is turned off\nPlease turn on Bluetooth...",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
      ),
      floatingActionButton:
          BluetoothPrintPlus.isBlueOn ? buildScanButton(context) : null,
    );
  }
}
