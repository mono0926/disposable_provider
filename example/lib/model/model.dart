import 'package:disposable_provider/disposable_provider.dart';
import 'package:rxdart/rxdart.dart';

class Model implements Disposable {
  final _countController = BehaviorSubject<int>.seeded(0);

  ValueStream<int> get count => _countController;

  void increment() => _countController.add(_countController.requireValue + 1);

  @override
  void dispose() async {
    await _countController.close();
  }
}
