import 'package:disposable_provider/disposable_provider.dart';
import 'package:example/model/model.dart';
import 'package:material_ui/material_ui.dart';

import 'detail_page.dart';

class const HomePage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disposable Provider Example')),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) => DisposableProvider(
          create: (context) => Model(),
          child: _Tile(key: ValueKey(index), index: index),
        ),
      ),
    );
  }
}

class const _Tile({super.key, required final int index})
    extends StatelessWidget {
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
                style: Theme.of(context).textTheme.titleMedium,
              );
            },
          ),
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
