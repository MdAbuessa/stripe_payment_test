import 'package:flutter/material.dart';

/// Bike Payment Success Dialog
///
/// বাইক কেনাকাটা সম্পন্ন হলে মানিসলিপ সদৃশ সফল পেমেন্ট ডায়ালগ দেখায়।
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
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green.shade200, width: 2),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                size: 48,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Payment Successful!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Your bike order has been confirmed',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Receipt Details
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Bike Name:', bikeTitle, isBold: true),
                  const SizedBox(height: 8),
                  _buildDetailRow('Transaction ID:', paymentId),
                  const SizedBox(height: 8),
                  _buildDetailRow('Payment Method:', 'Stripe (Card)'),
                  const Divider(height: 20),
                  _buildDetailRow(
                    'Amount Paid:',
                    '\$${amount.toStringAsFixed(2)}',
                    isPrimary: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Close Button
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String title,
    String value, {
    bool isBold = false,
    bool isPrimary = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight:
                  (isBold || isPrimary) ? FontWeight.bold : FontWeight.normal,
              fontSize: isPrimary ? 15 : 12,
              color: isPrimary ? Colors.green.shade700 : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
