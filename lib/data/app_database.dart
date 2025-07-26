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
  TextColumn get toolId => text().withLength(min: 1, max: 100)();
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

  Future<void> deleteWorker(int id) async {
    await (delete(workers)..where((w) => w.id.equals(id))).go();
  }

  Future<void> insertTool(ToolsCompanion tool) async {
    await into(tools).insert(tool);
  }

  Future<bool> updateTool(Tool tool) async {
    final cleanName = tool.name.trim().toLowerCase().replaceAll(
      RegExp(r'\s+'),
      ' ',
    );

    // تحقق من عدم وجود أداة أخرى بنفس الاسم
    final duplicate =
        await (select(tools)..where(
              (t) => t.name.equals(cleanName) & t.id.isNotValue(tool.id),
            ))
            .getSingleOrNull();

    if (duplicate != null) {
      return false; // أداة بنفس الاسم موجودة
    }

    // تعديل الأداة بعد تنظيف الاسم
    final updatedTool = tool.copyWith(name: cleanName);
    return update(tools).replace(updatedTool);
  }

  Future<Tool?> getToolById(int id) {
    return (select(tools)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<Tool?> getToolByName(String name) {
    final clean = name.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
    return (select(
      tools,
    )..where((t) => t.name.equals(clean))).getSingleOrNull();
  }

  Future<String> generateNextToolId() async {
    final allTools = await select(tools).get();
    final existingIds = allTools.map((t) => t.toolId).toList();

    final numbers = existingIds
        .map((id) => int.tryParse(id.replaceAll(RegExp(r'[^\d]'), '')) ?? 0)
        .toList();

    final nextNumber = (numbers.isEmpty
        ? 1
        : (numbers.reduce((a, b) => a > b ? a : b) + 1));
    return 'TOOL-${nextNumber.toString().padLeft(3, '0')}';
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
