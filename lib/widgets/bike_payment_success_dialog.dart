import 'package:flutter/material.dart';

class BikePaymentSuccessDialog extends StatelessWidget {
  final String bikeTitle;
  final double amount;
  final String paymentId;

  const BikePaymentSuccessDialog({
    super.key,
    required this.bikeTitle,
    required this.amount,
    required this.paymentId,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Green animated success badge
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green.shade300, width: 2),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 54,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Stripe Payment Success!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Verified transaction logged on Stripe Dashboard',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),

            // Transaction receipt card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  ReceiptRow(
                    title: 'Item Purchased:',
                    value: bikeTitle,
                    isBold: true,
                  ),
                  const SizedBox(height: 8),
                  ReceiptRow(
                    title: 'Amount Paid:',
                    value: '\$${amount.toStringAsFixed(2)}',
                    isPrimary: true,
                  ),
                  const SizedBox(height: 8),
                  ReceiptRow(
                    title: 'Payment ID:',
                    value: paymentId,
                    isSmall: true,
                  ),
                  const SizedBox(height: 8),
                  const ReceiptRow(
                    title: 'Gateway:',
                    value: 'Stripe Test API',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 15,
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
}

class ReceiptRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isBold;
  final bool isPrimary;
  final bool isSmall;

  const ReceiptRow({
    super.key,
    required this.title,
    required this.value,
    this.isBold = false,
    this.isPrimary = false,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: (isBold || isPrimary)
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontSize: isPrimary ? 15 : (isSmall ? 11 : 12),
              color: isPrimary ? Colors.green.shade700 : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
