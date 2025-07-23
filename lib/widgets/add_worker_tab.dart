import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' show Value;
import '../data/app_database.dart';
import '../data/database_provider.dart';
import '../widgets/custom_text_field.dart';
import '../utils/validators.dart';

class AddWorkerTab extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController jobTitleController;
  final TextEditingController departmentController;
  final TextEditingController hrCodeController;
  final List<String> nameSuggestions;
  final List<String> hrCodeSuggestions;
  final List<String> jobTitleSuggestions;
  final List<String> departmentSuggestions;
  const AddWorkerTab({
    super.key,
    required this.nameController,
    required this.jobTitleController,
    required this.departmentController,
    required this.hrCodeController,
    required this.nameSuggestions,
    required this.hrCodeSuggestions,
    required this.jobTitleSuggestions,
    required this.departmentSuggestions,
  });

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CustomTextField(
            hint: "Worker Name",
            controller: nameController,
            suggestions: nameSuggestions,
            onSelected: (val) => nameController.text = val,
          ),
          CustomTextField(
            hint: "Job Title",
            controller: jobTitleController,
            suggestions: jobTitleSuggestions,
            onSelected: (p0) => jobTitleController.text = p0,
          ),
          CustomTextField(
            hint: "Department",
            controller: departmentController,
            suggestions: departmentSuggestions,
            onSelected: (p0) => departmentController.text = p0,
          ),
          CustomTextField(
            hint: "HR Code",
            controller: hrCodeController,
            suggestions: hrCodeSuggestions,
            onSelected: (val) => hrCodeController.text = val,
          ),
          ElevatedButton(
            onPressed: () async {
              final name = cleanInput(nameController.text);
              final jobTitle = cleanInput(jobTitleController.text);
              final department = cleanInput(departmentController.text);
              final hrCode = cleanInput(hrCodeController.text);

              if (name.isEmpty ||
                  jobTitle.isEmpty ||
                  department.isEmpty ||
                  hrCode.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please fill in all fields properly."),
                  ),
                );
                return;
              }
              final worker = WorkersCompanion(
                name: Value(name),
                jobTitle: Value(jobTitle),
                department: Value(department),
                hrCode: Value(hrCode),
              );
              final success = await db.addWorker(worker);

              if (!context.mounted) return;

              if (success) {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Worker added successfully")),
                );
                nameController.clear();
                jobTitleController.clear();
                departmentController.clear();
                hrCodeController.clear();
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
    );
  }
}
