import 'package:riverpod/riverpod.dart';
// ignore: implementation_imports
import 'package:riverpod/src/framework/framework.dart';
// ignore: implementation_imports
import 'package:riverpod/src/provider/provider.dart';

import 'disposable.dart';

class DisposableProvider<T extends Disposable>
    extends AlwaysAliveProviderBase<ProviderDependency<T>, T> {
  /// Creates the initial value
  DisposableProvider(this._create, {String name}) : super(name);

  final Create<T, ProviderReference> _create;

  @override
  _ProviderState<T> createState() => _ProviderState();
}

class _ProviderState<T extends Disposable>
    extends ProviderStateBase<ProviderDependency<T>, T, DisposableProvider<T>> {
  @override
  T state;

  @override
  void initState() {
    // ignore: invalid_use_of_visible_for_testing_member
    state = provider._create(ProviderReference(this));
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }

  @override
  ProviderDependency<T> createProviderDependency() {
    return ProviderDependencyImpl(state);
  }
}

class DisposableProviderFamily<Result extends Disposable, A>
    extends Family<DisposableProvider<Result>, A> {
  /// Creates a value from an external parameter
  DisposableProviderFamily(Result Function(ProviderReference ref, A a) create)
      : super((a) => DisposableProvider((ref) => create(ref, a)));

  /// Overrides the behavior of a family for a part of the application.
  Override overrideAs(
    Result Function(ProviderReference ref, A value) override,
  ) {
    return FamilyOverride(
      this,
      (value) => DisposableProvider<Result>((ref) => override(ref, value as A)),
    );
  }
}
