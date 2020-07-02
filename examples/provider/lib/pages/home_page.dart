import 'package:disposable_provider/disposable_provider.dart';
import 'package:example/model/model.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disposable Provider Example'),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) => DisposableProvider(
          create: (context) => Model(),
          child: _Tile(
            key: ValueKey(index),
            index: index,
          ),
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final model = DisposableProvider.of<Model>(context);
    final count = model.count;
    return ListTile(
      title: Text('Counter $index'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<int>(
              initialData: count.value,
              stream: count,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.subtitle1,
                );
              }),
          const SizedBox(width: 16),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.add),
            onPressed: model.increment,
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push<void>(
          MaterialPageRoute(
            builder: (context) => DisposableProvider.value(
              value: model,
              child: const DetailPage(),
            ),
          ),
        );
      },
    );
  }
}
