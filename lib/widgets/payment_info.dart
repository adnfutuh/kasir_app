import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
              image: const DecorationImage(
                image: AssetImage('assets/images/check.png'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Payment Successful',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => context.go('/print'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'Print',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
