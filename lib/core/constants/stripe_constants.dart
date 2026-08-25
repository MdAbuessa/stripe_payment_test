/// Stripe API Configuration Constants
///
/// এই ফাইলে Stripe-এর Publishable Key, Secret Key এবং কারেন্সি ডিফল্ট কনফিগারেশন রাখা হয়েছে।
class StripeConstants {
  StripeConstants._();

  /// Stripe Publishable Key: অ্যাপ এবং Stripe SDK কানেক্ট করার জন্য ব্যবহার হয়।
  static const String publishableKey =
      'pk_test_51U615j4IrbdWrbaWn9jDJdg2puP5E2yw23Lzl2Uf3P93pLdJmF5ljin1vYraTTWk78cuAEFHjnegQnDJzVmmiaC9000WLsXPWD';

  /// Stripe Secret Key: Backend/PaymentIntent API কলের জন্য ব্যবহার হয়।
  /// NOTE: প্রফেশনাল প্রজেক্টে Secret Key ব্যাকএন্ড সার্ভারে রাখা উচিত। 
  static const String secretKey =
      'sk_test_51U615j4IrbdWrbaWW5QF1YmWuXQfgJilW5fGmfhJQRYjY0XxRY1hqyWvoMQQYfRtEs0PABGEzwsEW1KA5thIsgIw00ODGuaT2c';

  /// Default Currency for Payments
  static const String defaultCurrency = 'usd';

  /// Stripe Merchant Display Name
  static const String merchantDisplayName = 'Stripe Store';
}
