import 'package:disposable_provider/disposable_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final modelProvider = AutoDisposeDisposableProvider((ref) => _Model());
final modelProviderFamily = AutoDisposeDisposableProviderFamily<_Model, int>(
  (_ref, _index) => _Model(),
);

class _Model implements Disposable {
  final _countController = BehaviorSubject<int>.seeded(0);

  ValueStream<int> get count => _countController;

  void increment() => _countController.value++;

  @override
  void dispose() async {
    print('dispose called');
    await _countController.close();
  }
}
