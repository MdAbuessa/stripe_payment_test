import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payument/core/constants/stripe_constants.dart';
import 'package:stripe_payument/core/theme/app_theme.dart';
import 'package:stripe_payument/screens/home_screen.dart';

/// Flutter Application Entry Point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Stripe Publishable Key কনফিগার করা (Native SDK-তে কী পাস করে ইনিশিয়ালাইজ করা)
  Stripe.publishableKey = StripeConstants.publishableKey;
  await Stripe.instance.applySettings();

  runApp(const StripePaymentApp());
}

/// Root Application Widget
class StripePaymentApp extends StatelessWidget {
  const StripePaymentApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stripe Payment Gateway',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}
