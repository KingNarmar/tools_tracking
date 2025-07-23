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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Workers Manager")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(hint: "Worker Name", controller: _nameController),
            CustomTextField(hint: "Job Title", controller: _jobTitleController),
            CustomTextField(
              hint: "Department",
              controller: _departmentController,
            ),
            CustomTextField(hint: "HR Code", controller: _hrCodeController),
            ElevatedButton(
              onPressed: () async {
                final db = Provider.of<DatabaseProvider>(
                  context,
                  listen: false,
                ).database;
                final worker = WorkersCompanion(
                  name: Value(_nameController.text.trim()),
                  jobTitle: Value(_jobTitleController.text.trim()),
                  department: Value(_departmentController.text.trim()),
                  hrCode: Value(_hrCodeController.text.trim()),
                );
                final success = await db.addWorker(worker);
                final allWorkers = await db.getAllWorkers();
                for (final w in allWorkers) {
                  print('${w.name} - ${w.jobTitle} - ${w.hrCode}');
                }
                if (!context.mounted) return;

                if (success) {
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
}
