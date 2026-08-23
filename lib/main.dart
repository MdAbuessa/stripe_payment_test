import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payument/presentation/bike_cell_screen.dart';
import 'package:stripe_payument/presentation/e_commerch_screen.dart';

const String publichableKey =
    'pk_test_51U615j4IrbdWrbaWn9jDJdg2puP5E2yw23Lzl2Uf3P93pLdJmF5ljin1vYraTTWk78cuAEFHjnegQnDJzVmmiaC9000WLsXPWD';
const String secretKey =
    'sk_test_51U615j4IrbdWrbaWW5QF1YmWuXQfgJilW5fGmfhJQRYjY0XxRY1hqyWvoMQQYfRtEs0PABGEzwsEW1KA5thIsgIw00ODGuaT2c';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set Stripe Publishable Key provided from Stripe Dashboard 
  // এটি হল সেই পাবলিক কী যা Stripe আপনাকে দেয়। পেমেন্ট শুরু করতে বা UI কম্পোনেন্ট তৈরি করতে এটি প্রয়োজন হয়।
  Stripe.publishableKey = publichableKey;
  // Native SDK এক্টিভ করা: Dart-এ সেট করা Publishable Key-টি Android এবং iOS-এর আসল Stripe SDK-তে পাঠিয়ে সেটিকে চালু (Configure) করার জন্য।
  // ক্র্যাশ ও এরর রোধ করা: অ্যাপ চালু করার আগেই Stripe-কে রেডি করে রাখা, যাতে ইউজার পেমেন্ট করার সময় "SDK Not Initialized" এরর বা অ্যাপ ক্র্যাশ না করে।
  await Stripe.instance.applySettings(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce Stripe Payment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'E-Commerce Payment Gateway'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 98, 36, 204),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BikeCellScreen(),
                  ),
                );
              },
              child: const Text(
                "BIKE SALE & STRIPE PAYMENT",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ECommerchScreen(),
                  ),
                );
              },
              child: Text(
                "E-COMMERCE STORE WITH STRIPE PAYMENT",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
