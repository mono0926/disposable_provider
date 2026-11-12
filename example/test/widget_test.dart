import 'package:example/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Disposable Provider Example'), findsOneWidget);
    expect(find.text('Counter 0'), findsOneWidget);
  });
}
