import 'dart:math';
import 'package:flutter/material.dart';

class PaymentSuccessDialog extends StatelessWidget {
  final double totalAmount;
  final int itemCount;
  final VoidCallback onDone;

  const PaymentSuccessDialog({
    super.key,
    required this.totalAmount,
    required this.itemCount,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final orderId = 'ORD-${Random().nextInt(900000) + 100000}';
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success icon with circle glow
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green.shade200, width: 3),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                size: 54,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Payment Successful!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Thank you for your purchase',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),

            // Order Receipt summary card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildReceiptRow('Order Ref:', orderId, isBold: true),
                  const SizedBox(height: 8),
                  _buildReceiptRow('Total Items:', '$itemCount items'),
                  const SizedBox(height: 8),
                  _buildReceiptRow('Payment Method:', 'Stripe / Card'),
                  const Divider(height: 20),
                  _buildReceiptRow(
                    'Amount Paid:',
                    '\$${totalAmount.toStringAsFixed(2)}',
                    isPrimary: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Done button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onDone();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Continue Shopping',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String title, String value,
      {bool isBold = false, bool isPrimary = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: (isBold || isPrimary) ? FontWeight.bold : FontWeight.normal,
            fontSize: isPrimary ? 16 : 13,
            color: isPrimary ? Colors.green.shade700 : Colors.black87,
          ),
        ),
      ],
    );
  }
}
