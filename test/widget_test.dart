import 'package:flutter_test/flutter_test.dart';
import 'package:m0vieapp/main.dart';

void main() {
  testWidgets('MyApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Add tests here!
  });
}
