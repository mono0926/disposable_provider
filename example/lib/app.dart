import 'package:material_ui/material_ui.dart';

import 'pages/home_page.dart';

class const App({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}
