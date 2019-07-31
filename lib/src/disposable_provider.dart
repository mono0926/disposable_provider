import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'disposable.dart';

/// Thin wrapper of [Provider]
class DisposableProvider<T extends Disposable> extends Provider<T> {
  DisposableProvider({
    Key key,
    @required ValueBuilder<T> builder,
    Widget child,
  }) : super(
          key: key,
          builder: builder,
          dispose: (_context, disposable) => disposable.dispose(),
          child: child,
        );

  DisposableProvider.value({
    Key key,
    @required T value,
    Widget child,
  }) : super.value(
          key: key,
          value: value,
          child: child,
        );

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
