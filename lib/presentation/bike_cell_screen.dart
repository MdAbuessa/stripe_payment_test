import 'package:flutter/material.dart';
import 'package:stripe_payument/services/stripe_service.dart';

class BikeItem {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;

  BikeItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
  });
}

class BikeCellScreen extends StatefulWidget {
  const BikeCellScreen({super.key});

  @override
  State<BikeCellScreen> createState() => _BikeCellScreenState();
}

class _BikeCellScreenState extends State<BikeCellScreen> {
  // String? _processingBikeId;
  bool _isProcessingPayment = false;

  final List<BikeItem> _bikes = [
    BikeItem(
      id: '1',
      title: 'Yamaha R15 V4',
      subtitle: '155cc VVA Engine',
      price: 4200.00,
      imageUrl:
          'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '2',
      title: 'Kawasaki Ninja 400',
      subtitle: '399cc Parallel Twin',
      price: 5699.00,
      imageUrl:
          'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '3',
      title: 'Ducati Panigale V4',
      subtitle: '1103cc Desmosedici V4',
      price: 24995.00,
      imageUrl:
          'https://images.unsplash.com/photo-1615172282427-9a57ef2d142e?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '4',
      title: 'BMW S1000RR',
      subtitle: '999cc Inline-4 ShiftCam',
      price: 18295.00,
      imageUrl:
          'https://images.unsplash.com/photo-1591637333184-19aa84b3e01f?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '5',
      title: 'Honda CBR650R',
      subtitle: '649cc Inline-Four',
      price: 9899.00,
      imageUrl:
          'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '6',
      title: 'Harley Davidson 883',
      subtitle: '883cc Evolution V-Twin',
      price: 11249.00,
      imageUrl:
          'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '7',
      title: 'Harley Davidson 883',
      subtitle: '883cc Evolution V-Twin',
      price: 10.00,
      imageUrl:
          'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '8',
      title: 'Harley Davidson 883',
      subtitle: '883cc Evolution V-Twin',
      price: 20.00,
      imageUrl:
          'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=600&auto=format&fit=crop&q=80',
    ),
  ];

  Future<void> _handleStripePayment(BikeItem bike) async {
    if (_isProcessingPayment) return;

    setState(() {
      _isProcessingPayment = true;
    });

    try {
      final result = await StripeService.instance.makePayment(
        amount: bike.price,
        currency: 'usd',
        itemTitle: bike.title,
        context: context,
      );

      if (result != null && result['success'] == true && mounted) {
        _showSuccessDialog(
          bikeTitle: bike.title,
          amount: bike.price,
          paymentId: result['paymentId'] ?? 'N/A',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });
      }
    }
  }

  void _showSuccessDialog({
    required String bikeTitle,
    required double amount,
    required String paymentId,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
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
                      _buildReceiptRow(
                        'Item Purchased:',
                        bikeTitle,
                        isBold: true,
                      ),
                      const SizedBox(height: 8),
                      _buildReceiptRow(
                        'Amount Paid:',
                        '\$${amount.toStringAsFixed(2)}',
                        isPrimary: true,
                      ),
                      const SizedBox(height: 8),
                      _buildReceiptRow('Payment ID:', paymentId, isSmall: true),
                      const SizedBox(height: 8),
                      _buildReceiptRow('Gateway:', 'Stripe Test API'),
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
      },
    );
  }

  Widget _buildReceiptRow(
    String title,
    String value, {
    bool isBold = false,
    bool isPrimary = false,
    bool isSmall = false,
  }) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Bike Sale & Stripe Payment',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: GridView.builder(
            itemCount: _bikes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.70,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final bike = _bikes[index];
              // final isProcessing = _processingBikeId == bike.id;
              final isProcessing = _isProcessingPayment;

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bike Image
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: AspectRatio(
                        aspectRatio: 1.25,
                        child: Image.network(
                          bike.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.two_wheeler,
                                size: 48,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Card Info & Payment Button
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bike.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  bike.subtitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${bike.price.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: isProcessing
                                      ? null
                                      : () => _handleStripePayment(bike),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).primaryColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 6,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 1,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: isProcessing
                                      ? const SizedBox(
                                          width: 14,
                                          height: 14,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.payment, size: 14),
                                            SizedBox(width: 4),
                                            Text(
                                              'Payment',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
