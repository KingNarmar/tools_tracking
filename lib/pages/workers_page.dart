import 'package:drift/drift.dart' show Value;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools_tracking/data/app_database.dart';
import 'package:tools_tracking/data/database_provider.dart';
import 'package:tools_tracking/widgets/custom_text_field.dart';

class WorkersPage extends StatefulWidget {
  const WorkersPage({super.key});

  @override
  State<WorkersPage> createState() => _WorkersPageState();
}

class _WorkersPageState extends State<WorkersPage> {
  final _nameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _departmentController = TextEditingController();
  final _hrCodeController = TextEditingController();
  List<String> workerNames = [];
  List<String> hrCodes = [];
  List<String> jobTitles = [];
  List<String> departments = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final db = Provider.of<DatabaseProvider>(context, listen: false).database;
      fetchSuggestions(db);
    });
  }

  Future<void> fetchSuggestions(AppDatabase db) async {
    final workers = await db.getAllWorkers();
    setState(() {
      workerNames = workers.map((w) => w.name.trim()).toList();
      hrCodes = workers.map((w) => w.hrCode.trim()).toList();
      jobTitles = workers.map((w) => w.jobTitle.trim()).toList();
      departments = workers.map((w) => w.department.trim()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Workers Manager")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              hint: "Worker Name",
              controller: _nameController,
              suggestions: workerNames,
              onSelected: (val) => _nameController.text = val,
            ),
            CustomTextField(
              hint: "Job Title",
              controller: _jobTitleController,
              suggestions: jobTitles,
              onSelected: (val) => _jobTitleController.text = val,
            ),
            CustomTextField(
              hint: "Department",
              controller: _departmentController,
              suggestions: departments,
              onSelected: (val) => _departmentController.text = val,
            ),
            CustomTextField(
              hint: "HR Code",
              controller: _hrCodeController,
              suggestions: hrCodes,
              onSelected: (val) => _hrCodeController.text = val,
            ),
            ElevatedButton(
              onPressed: () async {
                final db = Provider.of<DatabaseProvider>(
                  context,
                  listen: false,
                ).database;
                final worker = WorkersCompanion(
                  name: Value(cleanInput(_nameController.text)),
                  jobTitle: Value(cleanInput(_jobTitleController.text)),
                  department: Value(cleanInput(_departmentController.text)),
                  hrCode: Value(cleanInput(_hrCodeController.text)),
                );
                final success = await db.addWorker(worker);
                final allWorkers = await db.getAllWorkers();
                for (final w in allWorkers) {
                  print('${w.name} - ${w.jobTitle} - ${w.hrCode}');
                }
                if (!context.mounted) return;

                if (success) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Worker added successfully")),
                  );
                  _nameController.clear();
                  _jobTitleController.clear();
                  _departmentController.clear();
                  _hrCodeController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("This HR code already exists")),
                  );
                }
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _departmentController.dispose();
    _hrCodeController.dispose();
    super.dispose();
  }

  String cleanInput(String input) {
    return input
        .trim() // يشيل المسافات من أول وآخر النص
        .replaceAll(RegExp(r'\s+'), ' ') // يشيل أي مسافات زيادة
        .toLowerCase(); // يخلي الحروف كلها small
  }
}
