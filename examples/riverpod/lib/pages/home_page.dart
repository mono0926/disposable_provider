import 'package:disposable_provider/disposable_provider.dart';
import 'package:example/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
        itemBuilder: (context, index) => ProviderScope(
          key: ValueKey(index),
          overrides: [
            modelProvider.overrideAs(
              Provider((ref) => ref.read(modelProviderFamily(index))),
            )
          ],
          child: _Tile(index: index),
        ),
      ),
    );
  }
}

class _Tile extends HookWidget {
  const _Tile({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final model = useProvider(modelProvider);
    final count = model.count;
    final p = modelProviderFamily(index);
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
            builder: (context) => ProviderScope(
              // Need for passing same provider because the provider of [_Tile]
              // was provided on each ProviderScope
              overrides: [
                modelProvider.overrideAs(
                  Provider((ref) => ref.read(modelProviderFamily(index))),
                )
              ],
              child: const DetailPage(),
            ),
          ),
        );
      },
    );
  }
}
