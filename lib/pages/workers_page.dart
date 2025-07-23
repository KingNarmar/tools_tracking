import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools_tracking/data/app_database.dart';
import 'package:tools_tracking/data/database_provider.dart';
import 'package:tools_tracking/widgets/add_worker_tab.dart';

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
  List<String> nameSuggestions = [];
  List<String> hrCodeSuggestions = [];
  List<String> jobTitleSuggestions = [];
  List<String> departmentSuggestions = [];
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
      nameSuggestions = workers.map((w) => w.name.trim()).toSet().toList();
      hrCodeSuggestions = workers.map((w) => w.hrCode.trim()).toSet().toList();
      jobTitleSuggestions = workers
          .map((w) => w.jobTitle.trim())
          .toSet()
          .toList();
      departmentSuggestions = workers
          .map((w) => w.department.trim())
          .toSet()
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Workers Manager"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Add New Worker"),
              Tab(text: "Manage Workers"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AddWorkerTab(
              nameController: _nameController,
              jobTitleController: _jobTitleController,
              departmentController: _departmentController,
              hrCodeController: _hrCodeController,
              nameSuggestions: nameSuggestions,
              hrCodeSuggestions: hrCodeSuggestions,
              jobTitleSuggestions: jobTitleSuggestions,
              departmentSuggestions: departmentSuggestions,
            ),
            Container(),
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
