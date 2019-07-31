import 'package:disposable_provider/disposable_provider.dart';
import 'package:rxdart/rxdart.dart';

class Model implements Disposable {
  final _countController = BehaviorSubject<int>.seeded(0);

  ValueObservable<int> get count => _countController;

  void increment() => _countController.value++;

  @override
  void dispose() async {
    await _countController.close();
  }
}
