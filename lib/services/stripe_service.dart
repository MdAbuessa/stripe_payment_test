import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payument/main.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  /// Calls Stripe REST API to create a Payment Intent
  Future<Map<String, dynamic>?> createPaymentIntent(
    double amount,
    String currency,
  ) async {
    try {
      final amountInCents = (amount * 100).toInt().toString();

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': amountInCents,
          'currency': currency,
          'payment_method_types[]': 'card',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        debugPrint('Stripe PaymentIntent Creation Error: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Error creating payment intent: $e');
      return null;
    }
  }

  /// Manages the full Stripe PaymentSheet flow
  Future<Map<String, dynamic>?> makePayment({
    required double amount,
    required String currency,
    required String itemTitle,
    required BuildContext context,
  }) async {
    try {
      // 1. Create Payment Intent
      final paymentIntent = await createPaymentIntent(amount, currency);
      if (paymentIntent == null || paymentIntent['client_secret'] == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to initialize payment with Stripe.'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return null;
      }

      final clientSecret = paymentIntent['client_secret'] as String;

      // 2. Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Bike Cell Shop',
          style: ThemeMode.light,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Color(0xFF6772E5), // Stripe brand color
            ),
          ),
        ),
      );

      // 3. Display Payment Sheet
      await Stripe.instance.presentPaymentSheet();

      // 4. Return payment details on success
      return {
        'success': true,
        'paymentId': paymentIntent['id'],
        'amount': amount,
        'currency': currency,
        'itemTitle': itemTitle,
      };
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        debugPrint('Payment canceled by user');
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Stripe Error: ${e.error.localizedMessage}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
      return null;
    } catch (e) {
      debugPrint('Stripe Payment Failure: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment Exception: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return null;
    }
  }
}
