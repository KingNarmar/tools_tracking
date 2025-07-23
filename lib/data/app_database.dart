import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'dart:io';
part 'app_database.g.dart';

// workers table
class Workers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get jobTitle => text().withLength(min: 1, max: 100)();
  TextColumn get department => text().withLength(min: 1, max: 100)();
  TextColumn get hrCode => text().withLength(min: 1, max: 100)();
}

// Tools Table
class Tools extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get unit => text().withLength(min: 1, max: 100)();
}

// Transactions Table

class Transactions extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  IntColumn get workerId => integer().references(Workers, #id)();
  IntColumn get toolId => integer().references(Tools, #id)();
  IntColumn get issueQty => integer().withDefault(Constant(0))();
  IntColumn get returnQty => integer().withDefault(Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Workers, Tools, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;
  Future<bool> hrCodeExists(String hrCode) async {
    final normalized = hrCode.trim().toLowerCase();
    final query = select(workers)..where((w) => w.hrCode.equals(normalized));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  Future<bool> addWorker(WorkersCompanion worker) async {
    final exists = await hrCodeExists(worker.hrCode.value);
    if (exists) return false;
    await into(workers).insert(worker);
    return true;
  }

  Future<bool> updateWorker(Worker worker) async {
    final normalizedHrCode = worker.hrCode.trim().toLowerCase();

    final duplicate =
        await (select(workers)..where(
              (w) =>
                  w.hrCode.equals(normalizedHrCode) &
                  w.id.isNotValue(worker.id),
            ))
            .getSingleOrNull();

    if (duplicate != null) return false;

    return update(workers).replace(worker);
  }

  Future<List<Worker>> getAllWorkers() {
    return select(workers).get();
  }

  Future<List<String>> getAllWorkerNames() async {
    final query = select(workers);
    final result = await query.get();
    return result.map((w) => w.name).toList();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder =
        await getApplicationDocumentsDirectory(); // نجيب مسار حفظ البيانات
    final file = File(
      p.join(dbFolder.path, 'tools_tracking.sqlite'),
    ); // اسم ملف الداتا بيز
    return NativeDatabase(file);
  });
}
