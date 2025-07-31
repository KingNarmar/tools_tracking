// app_database.dart (بعد التصحيح النهائي)
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'app_database.g.dart';

// Tables
class Workers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get jobTitle => text().withLength(min: 1, max: 100)();
  TextColumn get department => text().withLength(min: 1, max: 100)();
  TextColumn get hrCode => text().withLength(min: 1, max: 100)();
}

class Tools extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get toolId => text().withLength(min: 1, max: 100)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get unit => text().withLength(min: 1, max: 100)();
}

class TransactionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get transactionId => text()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  IntColumn get workerId => integer().references(Workers, #id)();
  IntColumn get toolId => integer().references(Tools, #id)();
  IntColumn get issue => integer().withDefault(const Constant(0))();
  IntColumn get returnQty => integer().withDefault(const Constant(0))();
  TextColumn get issueImagePath =>
      text().named('issue_image_path').nullable()();
  TextColumn get returnImagePath =>
      text().named('return_image_path').nullable()();
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 3, max: 50)();
  TextColumn get password => text().withLength(min: 6, max: 100)();
  TextColumn get role =>
      text().withLength(min: 1, max: 50).withDefault(const Constant("user"))();
}

@DriftDatabase(tables: [Workers, Tools, TransactionsTable, Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Users
  Future<User?> getUserByCredentials(String username, String password) async {
    return (select(users)..where(
          (u) => u.username.equals(username) & u.password.equals(password),
        ))
        .getSingleOrNull();
  }

  // Workers
  Future<bool> hrCodeExists(String hrCode) async {
    final normalized = hrCode.trim().toLowerCase();
    final query = select(workers)..where((w) => w.hrCode.equals(normalized));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  Future<Worker> getWorkerById(int id) {
    return (select(workers)..where((w) => w.id.equals(id))).getSingle();
  }

  Future<Worker?> getWorkerByName(String name) async {
    final clean = name.trim().toLowerCase();
    return (select(
      workers,
    )..where((tbl) => tbl.name.equals(clean))).getSingleOrNull();
  }

  Future<List<Worker>> getWorkersByPartialName(String query) {
    final clean = query.trim().toLowerCase();
    return (select(
      workers,
    )..where((w) => w.name.lower().like('%$clean%'))).get();
  }

  Future<List<Worker>> getAllWorkers() => select(workers).get();

  Future<List<String>> getAllWorkerNames() async =>
      (await select(workers).get()).map((w) => w.name).toList();

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

  Future<void> deleteWorker(int id) async =>
      (delete(workers)..where((w) => w.id.equals(id))).go();

  // Tools
  Future<Tool?> getToolByName(String name) async {
    final clean = name.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
    return (select(
      tools,
    )..where((t) => t.name.equals(clean))).getSingleOrNull();
  }

  Future<List<Tool>> getToolsByPartialName(String query) {
    final clean = query.trim().toLowerCase();
    return (select(tools)..where((t) => t.name.lower().like('%$clean%'))).get();
  }

  Future<Tool?> getToolById(int id) =>
      (select(tools)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> insertTool(ToolsCompanion tool) async =>
      into(tools).insert(tool);

  Future<bool> updateTool(Tool tool) async {
    final cleanName = tool.name.trim().toLowerCase().replaceAll(
      RegExp(r'\s+'),
      ' ',
    );
    final duplicate =
        await (select(tools)..where(
              (t) => t.name.equals(cleanName) & t.id.isNotValue(tool.id),
            ))
            .getSingleOrNull();
    if (duplicate != null) return false;
    return update(tools).replace(tool.copyWith(name: cleanName));
  }

  Future<String> generateNextToolId() async {
    final allTools = await select(tools).get();
    final numbers = allTools
        .map(
          (t) => int.tryParse(t.toolId.replaceAll(RegExp(r'[^\d]'), '')) ?? 0,
        )
        .toList();
    final nextNumber = numbers.isEmpty
        ? 1
        : (numbers.reduce((a, b) => a > b ? a : b) + 1);
    return 'TOOL-${nextNumber.toString().padLeft(3, '0')}';
  }

  // Transactions
  Future<int> getWorkerToolBalance(int workerId, int toolId) async {
    final trxList =
        await (select(transactionsTable)..where(
              (t) => t.workerId.equals(workerId) & t.toolId.equals(toolId),
            ))
            .get();
    final totalIssue = trxList.fold<int>(0, (sum, trx) => sum + trx.issue);
    final totalReturn = trxList.fold<int>(0, (sum, trx) => sum + trx.returnQty);
    return totalIssue - totalReturn;
  }

  Future<void> insertTransaction(TransactionsTableCompanion data) async =>
      into(transactionsTable).insert(data);

  Future<String> generateNextTransactionId() async {
    final lastId =
        await (select(transactionsTable)
              ..orderBy([(t) => OrderingTerm.desc(t.transactionId)])
              ..limit(1))
            .getSingleOrNull();
    if (lastId == null) return 'TRX-001';
    final lastNum = int.tryParse(lastId.transactionId.split('-').last) ?? 0;
    return 'TRX-${(lastNum + 1).toString().padLeft(3, '0')}';
  }

  Future<void> deleteTransaction(int id) async =>
      (delete(transactionsTable)..where((t) => t.id.equals(id))).go();

  Future<List<TransactionWithDetails>> getAllTransactionsWithDetails() {
    final trx =
        (select(
          transactionsTable,
        )..orderBy([(t) => OrderingTerm.desc(t.date)])).join([
          leftOuterJoin(
            workers,
            workers.id.equalsExp(transactionsTable.workerId),
          ),
          leftOuterJoin(tools, tools.id.equalsExp(transactionsTable.toolId)),
        ]);

    return trx.map((row) {
      return TransactionWithDetails(
        transaction: row.readTable(transactionsTable),
        worker: row.readTable(workers),
        tool: row.readTable(tools),
      );
    }).get();
  }
}

class TransactionWithDetails {
  final TransactionsTableData transaction;
  final Worker worker;
  final Tool tool;

  TransactionWithDetails({
    required this.transaction,
    required this.worker,
    required this.tool,
  });

  DateTime get date => transaction.date;
  int get issue => transaction.issue;
  int get returned => transaction.returnQty;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tools_tracking.sqlite'));
    print("DB PATH: \${file.path}");
    return NativeDatabase(file);
  });
}
