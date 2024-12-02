import 'item_model.dart';

class Order {
  final String orderId;
  final List<Item> items;
  final double totalAmount;
  final DateTime createdAt;

  Order({
    required this.orderId,
    required this.items,
    required this.totalAmount,
    required this.createdAt,
  });
}
