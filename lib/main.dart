import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tools_tracking/data/database_provider.dart';
import 'package:tools_tracking/pages/main_menu_page.dart';

Future<void> main() async {
  runApp(
    Provider<DatabaseProvider>.value(
      value: DatabaseProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainMenuPage(),
    );
  }
}
