import 'package:disposable_provider/disposable_provider.dart';
import 'package:riverpod/riverpod.dart';
// ignore: implementation_imports
import 'package:riverpod/src/framework/framework.dart';

class AutoDisposeDisposableProvider<T extends Disposable>
    extends AutoDisposeProvider<T> {
  AutoDisposeDisposableProvider(
    Create<T, AutoDisposeProviderReference> create, {
    String name,
  }) : super(
          (ref) {
            final disposable = create(ref);
            ref.onDispose(disposable.dispose);
            return disposable;
          },
          name: name,
        );
}

class AutoDisposeDisposableProviderFamily<Result extends Disposable, A>
    extends Family<AutoDisposeDisposableProvider<Result>, A> {
  AutoDisposeDisposableProviderFamily(
      Result Function(AutoDisposeProviderReference ref, A a) create)
      : super((a) => AutoDisposeDisposableProvider((ref) => create(ref, a)));

  Override overrideAs(
    Result Function(AutoDisposeProviderReference ref, A value) override,
  ) {
    return FamilyOverride(
      this,
      (value) {
        return AutoDisposeDisposableProvider<Result>(
          (ref) => override(ref, value as A),
        );
      },
    );
  }
}
