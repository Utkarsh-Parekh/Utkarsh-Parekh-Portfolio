import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PortfolioApp());

    // Verify the app loads successfully
    expect(find.text('Hello, I\'m'), findsOneWidget);
    expect(find.text('Utkarsh Parekh'), findsOneWidget);
  });
}
