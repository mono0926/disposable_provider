import 'package:disposable_provider/disposable_provider.dart';
import 'package:example/model/model.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = DisposableProvider.of<Model>(context);
    final count = model.count;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Detail'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          initialData: count.value,
          stream: count,
          builder: (context, snapshot) {
            return Text(
              'count: ${snapshot.data}',
              style: Theme.of(context).textTheme.headline4,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: model.increment,
      ),
    );
  }
}
