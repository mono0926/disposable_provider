import 'package:disposable_provider/disposable_provider.dart';
import 'package:example/model/model.dart';
import 'package:material_ui/material_ui.dart';

class const DetailPage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = DisposableProvider.of<Model>(context);
    final count = model.count;
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Detail')),
      body: Center(
        child: StreamBuilder<int>(
          initialData: count.value,
          stream: count,
          builder: (context, snapshot) {
            return Text(
              'count: ${snapshot.data}',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: model.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
