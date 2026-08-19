import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payument/presentation/bike_cell_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set Stripe Publishable Key provided from Stripe Dashboard
  Stripe.publishableKey =
      'pk_test_51U615j4IrbdWrbaWn9jDJdg2puP5E2yw23Lzl2Uf3P93pLdJmF5ljin1vYraTTWk78cuAEFHjnegQnDJzVmmiaC9000WLsXPWD';
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BikeCellScreen(),
                  ),
                );
              },
              child: const Text("BIKE SALE & STRIPE PAYMENT"),
            ),
          ],
        ),
      ),
    );
  }
}
