import 'package:flutter/material.dart';
import 'package:stripe_payument/core/constants/stripe_constants.dart';
import 'package:stripe_payument/core/services/stripe_service.dart';
import 'package:stripe_payument/models/bike_item.dart';
import 'package:stripe_payument/widgets/bike/bike_card.dart';
import 'package:stripe_payument/widgets/bike/bike_payment_success_dialog.dart';

/// Bike Sale Screen Component
///
/// প্রতিটি বাইক প্রোডাক্টের জন্য একক আইটেম সরাসরি Stripe-এর মাধ্যমে ক্রয় করার স্ক্রিন।
class BikeCellScreen extends StatefulWidget {
  const BikeCellScreen({super.key});

  @override
  State<BikeCellScreen> createState() => _BikeCellScreenState();
}

class _BikeCellScreenState extends State<BikeCellScreen> {
  /// পেমেন্ট চলাকালীন ডুপ্লিকেট ক্লিক ঠেকাতে ফ্ল্যাগ
  bool _isProcessingPayment = false;

  /// স্যাম্পল বাইক প্রোডাক্ট লিস্ট
  final List<BikeItem> _bikes = [
    BikeItem(
      id: '1',
      title: 'Yamaha R15 V4',
      subtitle: '155cc VVA Engine',
      price: 420.00,
      imageUrl:
          'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '2',
      title: 'Kawasaki Ninja 400',
      subtitle: '399cc Parallel Twin',
      price: 569.00,
      imageUrl:
          'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '3',
      title: 'Ducati Panigale V4',
      subtitle: '1103cc Desmosedici V4',
      price: 245.00,
      imageUrl:
          'https://images.unsplash.com/photo-1615172282427-9a57ef2d142e?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '4',
      title: 'BMW S1000RR',
      subtitle: '999cc Inline-4 ShiftCam',
      price: 295.00,
      imageUrl:
          'https://images.unsplash.com/photo-1591637333184-19aa84b3e01f?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '5',
      title: 'Honda CBR650R',
      subtitle: '649cc Inline-Four',
      price: 98.00,
      imageUrl:
          'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '6',
      title: 'Harley Davidson 883',
      subtitle: '883cc Evolution V-Twin',
      price: 149.00,
      imageUrl:
          'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '7',
      title: 'Harley Davidson Custom',
      subtitle: '883cc Evolution V-Twin',
      price: 100.00,
      imageUrl:
          'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=600&auto=format&fit=crop&q=80',
    ),
    BikeItem(
      id: '8',
      title: 'Yamaha Sport Pro',
      subtitle: '155cc VVA Engine',
      price: 100.00,
      imageUrl:
          'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=600&auto=format&fit=crop&q=80',
    ),
  ];

  // ===========================================================================
  // STRIPE PAYMENT HANDLER FOR SINGLE BIKE ITEM
  // ===========================================================================
  /// বাইকের 'Buy' বাটন চাপলে Stripe Payment প্রসেস শুরু করে।
  Future<void> _handleStripePayment(BikeItem bike) async {
    if (_isProcessingPayment) return;

    setState(() {
      _isProcessingPayment = true;
    });

    try {
      // 1. StripeService-এর মাধ্যমে পেমেন্ট কমপ্লিট করা
      final result = await StripeService.instance.makePayment(
        amount: bike.price,
        currency: StripeConstants.defaultCurrency,
        itemTitle: bike.title,
        context: context,
      );

      // 2. পেমেন্ট সফল হলে কনফার্মেশন ডায়ালগ প্রর্দশন করা
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

  /// পেমেন্ট সফল ডায়ালগ দেখানো
  void _showSuccessDialog({
    required String bikeTitle,
    required double amount,
    required String paymentId,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BikePaymentSuccessDialog(
          bikeTitle: bikeTitle,
          amount: amount,
          paymentId: paymentId,
        );
      },
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
              return BikeCard(
                bike: bike,
                isProcessing: _isProcessingPayment,
                onPaymentPressed: () => _handleStripePayment(bike),
              );
            },
          ),
        ),
      ),
    );
  }
}
