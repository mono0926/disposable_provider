import 'package:example/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailPage extends HookWidget {
  const DetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = useProvider(modelProvider);
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
        child: const Icon(Icons.add),
        onPressed: model.increment,
      ),
    );
  }
}
