import 'package:flutter_test/flutter_test.dart';
import 'package:stripe_payument/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StripePaymentApp());

    // Verify that the title is present
    expect(find.text('Stripe Payment Demos'), findsOneWidget);
  });
}
