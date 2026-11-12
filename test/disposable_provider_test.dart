import 'package:disposable_provider/disposable_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestDisposable() implements Disposable {
  bool isDisposed = false;
  int count = 0;

  @override
  void dispose() {
    isDisposed = true;
  }
}

void main() {
  testWidgets(
    'DisposableProvider provides instance and disposes on unmount',
    (tester) async {
      late _TestDisposable captured;

      await tester.pumpWidget(
        DisposableProvider<_TestDisposable>(
          create: (_) => _TestDisposable(),
          child: Builder(
            builder: (context) {
              captured = DisposableProvider.of<_TestDisposable>(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(captured.isDisposed, isFalse);

      await tester.pumpWidget(const SizedBox.shrink());

      expect(captured.isDisposed, isTrue);
    },
  );

  testWidgets(
    'DisposableProvider.value provides existing instance without disposing it',
    (tester) async {
      final disposable = _TestDisposable()..count = 42;
      late _TestDisposable captured;

      await tester.pumpWidget(
        DisposableProvider<_TestDisposable>.value(
          value: disposable,
          child: Builder(
            builder: (context) {
              captured = DisposableProvider.of<_TestDisposable>(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(captured, same(disposable));
      expect(captured.count, 42);

      await tester.pumpWidget(const SizedBox.shrink());

      expect(disposable.isDisposed, isFalse);
    },
  );

  testWidgets(
    'DisposableProvider.of throws FlutterError when provider is missing',
    (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            capturedContext = context;
            return const SizedBox.shrink();
          },
        ),
      );

      expect(
        () => DisposableProvider.of<_TestDisposable>(capturedContext),
        throwsFlutterError,
      );
    },
  );
}
