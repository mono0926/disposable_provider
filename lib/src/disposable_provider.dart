import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'disposable.dart';

/// Thin wrapper of [Provider]
class DisposableProvider<T extends Disposable> extends Provider<T> {
  new({
    super.key,
    required super.create,
    super.child,
    super.builder,
    super.lazy,
  }) : super(
         dispose: (context, disposable) => disposable.dispose(),
       );

  new value({
    super.key,
    required super.value,
    super.child,
    super.builder,
  }) : super.value();

  /// Thin wrapper of Provider.of
  static T of<T extends Disposable>(BuildContext context) {
    try {
      return Provider.of<T>(context, listen: false);
    } catch (error) {
      throw FlutterError(
        '''
        DisposableProvider.of() called with a context that does not contain
        a Disposable of type $T.
        The context used was: $context
        Error: $error
        ''',
      );
    }
  }
}
