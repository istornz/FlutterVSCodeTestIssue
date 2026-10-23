import 'package:app/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

Future<void> _launchAndIncrement(WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('increment')));
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 3));
  expect(find.text('1'), findsOneWidget);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Group A', () {
    testWidgets('test A1', _launchAndIncrement);
    testWidgets('test A2', _launchAndIncrement);
    testWidgets('test A3', _launchAndIncrement);
  });

  group('Group B', () {
    testWidgets('test B1', _launchAndIncrement);
    testWidgets('test B2', _launchAndIncrement);
    testWidgets('test B3', _launchAndIncrement);
  });
}
