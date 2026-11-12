import 'package:disposable_provider/disposable_provider.dart';
import 'package:rxdart/rxdart.dart';

class Model() implements Disposable {
  final _countController = BehaviorSubject<int>.seeded(0);

  ValueStream<int> get count => _countController;

  void increment() => _countController.add(_countController.value + 1);

  @override
  Future<void> dispose() async {
    await _countController.close();
  }
}
