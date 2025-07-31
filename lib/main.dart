import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools_tracking/data/app_database.dart';
import 'package:tools_tracking/data/database_provider.dart';
import 'package:tools_tracking/pages/login_page.dart';
import 'package:tools_tracking/pages/main_menu_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbProvider = DatabaseProvider();
  final db = dbProvider.database;

  // ✅ إنشاء أول مستخدم افتراضي إذا لم يكن موجودًا
  final existingUsers = await db.select(db.users).get();
  if (existingUsers.isEmpty) {
    await db
        .into(db.users)
        .insert(
          UsersCompanion.insert(
            username: 'admin',
            password: 'admin123',
            role: const Value('admin'),
          ),
        );
    print("✅ Default user created: admin / admin123");
  }

  runApp(Provider<DatabaseProvider>.value(value: dbProvider, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tools Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(
        onLoginSuccess: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainMenuPage()),
          );
        },
      ),
    );
  }
}
