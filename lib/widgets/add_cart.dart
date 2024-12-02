import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/item_model.dart';

class AddCart extends StatelessWidget {
  final List<Item> item;
  final int selectedQuantity;

  const AddCart({
    super.key,
    required this.selectedQuantity,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;

    for (var i = 0; i < item.length; i++) {
      totalPrice += item[i].totalPrice;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$selectedQuantity Items selected',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          GestureDetector(
            onTap: () => context.go('/order'),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange,
              ),
              child: Row(
                children: [
                  Text(
                    'Rp ${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    CupertinoIcons.arrow_right,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
