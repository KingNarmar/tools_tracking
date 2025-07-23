import 'package:tools_tracking/data/app_database.dart';

class DatabaseProvider {
  late AppDatabase database;

  DatabaseProvider() {
    database = AppDatabase();
  }
}
