import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MakandApp());

    expect(find.text('Makand'), findsNothing);
    expect(find.text('Bienvenido'), findsOneWidget);
  });
}
