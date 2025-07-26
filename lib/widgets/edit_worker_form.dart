import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' show Value;
import '../data/app_database.dart';
import '../data/database_provider.dart';
import 'custom_text_field.dart';
import '../utils/validators.dart';

class EditWorkerForm extends StatefulWidget {
  final Worker worker;
  final VoidCallback onUpdated;

  const EditWorkerForm({
    super.key,
    required this.worker,
    required this.onUpdated,
  });

  @override
  State<EditWorkerForm> createState() => _EditWorkerFormState();
}

class _EditWorkerFormState extends State<EditWorkerForm> {
  late TextEditingController nameController;
  late TextEditingController jobTitleController;
  late TextEditingController departmentController;
  late TextEditingController hrCodeController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.worker.name);
    jobTitleController = TextEditingController(text: widget.worker.jobTitle);
    departmentController = TextEditingController(
      text: widget.worker.department,
    );
    hrCodeController = TextEditingController(text: widget.worker.hrCode);
  }

  @override
  void dispose() {
    nameController.dispose();
    jobTitleController.dispose();
    departmentController.dispose();
    hrCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    return AlertDialog(
      title: Text('Edit Worker'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(hint: "Name", controller: nameController),
            CustomTextField(hint: "Job Title", controller: jobTitleController),
            CustomTextField(
              hint: "Department",
              controller: departmentController,
            ),
            CustomTextField(hint: "HR Code", controller: hrCodeController),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final updatedWorker = Worker(
              id: widget.worker.id,
              name: cleanInput(nameController.text),
              jobTitle: cleanInput(jobTitleController.text),
              department: cleanInput(departmentController.text),
              hrCode: cleanInput(hrCodeController.text),
            );

            final success = await db.updateWorker(updatedWorker);

            if (!mounted) return;

            if (success) {
              Navigator.of(context).pop();
              widget.onUpdated();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Worker updated successfully")),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("HR Code already exists for another worker."),
                ),
              );
            }
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
