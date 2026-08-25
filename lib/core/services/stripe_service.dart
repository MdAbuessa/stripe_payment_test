import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payument/core/constants/stripe_constants.dart';

/// Stripe Payment Management Service
/// Stripe SDK এবং REST API এর মাধ্যমে পেমেন্ট কমপ্লিট করার পুরো প্রসেস এই ক্লাসে হ্যান্ডেল করা হয়েছে।
class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();
  // ===========================================================================
  // STEP 1: CREATE PAYMENT INTENT VIA STRIPE REST API
  // ===========================================================================
  /// Stripe REST API তে HTTP Post পাঠিয়ে Payment Intent তৈরি করা হয়।
  // / [amount] : পেমেন্টের পরিমাণ (USD বা নির্ধারিত কারেন্সি)
  // / [currency] : কারেন্সির নাম (যেমন 'usd')
  Future<Map<String, dynamic>?> createPaymentIntent(
    double amount,
    String currency,
  ) async {
    try {
      // Stripe API সবসময় পরিমাণ সেন্টস (cents) এ হিসেব করে (যেমন $10 = 1000 cents)
      final amountInCents = (amount * 100).toInt().toString();
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${StripeConstants.secretKey}',
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
        debugPrint('Stripe PaymentIntent Error: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Error creating PaymentIntent: $e');
      return null;
    }
  }

  // ===========================================================================
  // STEP 2 & 3: INITIALIZE & PRESENT STRIPE PAYMENT SHEET
  // ===========================================================================
  /// সম্পূর্ণ পেমেন্ট প্রসেস পরিচালনা করে:
  /// 1. Payment Intent তৈরি করে clientSecret সংগ্রহ করে।
  /// 2. Stripe Native Payment Sheet ইনিশিয়ালাইজ করে।
  /// 3. ইউজারের সামনে Payment Sheet ওপেন করে।
  /// 4. ফলাফল ফেরত পাঠায়।
  Future<Map<String, dynamic>?> makePayment({
    required double amount,
    required String currency,
    required String itemTitle,
    required BuildContext context,
  }) async {
    try {
      // 1. Payment Intent তৈরি করা
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

      // 2. Stripe Payment Sheet ইনিশিয়ালাইজ করা
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: StripeConstants.merchantDisplayName,
          style: ThemeMode.light,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Color(0xFF6772E5), // Stripe brand color
            ),
          ),
        ),
      );

      // 3. ইউজারের সামনে Native Payment Sheet পপআপ দেখানো
      await Stripe.instance.presentPaymentSheet();

      // 4. পেমেন্ট সফল হলে পেমেন্ট হিস্ট্রি অবজেক্ট রিটার্ন করা
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
      debugPrint('Stripe Payment Exception: $e');
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
