// reports_page.dart (بعد التعديل الكامل)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools_tracking/data/app_database.dart';
import 'package:tools_tracking/data/database_provider.dart';
import 'package:tools_tracking/utils/pdf_generator.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<TransactionWithDetails> allTransactions = [];
  List<TransactionWithDetails> filteredTransactions = [];
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController hrCodeController = TextEditingController();

  Map<String, String> nameToHrMap = {}; // name => hrCode
  Map<String, String> hrToNameMap = {}; // hrCode => name

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
    searchController.addListener(_filterTransactions);
  }

  Future<void> _fetchTransactions() async {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    final transactions = await db.getAllTransactionsWithDetails();
    setState(() {
      allTransactions = transactions;
      filteredTransactions = transactions;
    });
  }

  void _filterTransactions() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredTransactions = allTransactions.where((trx) {
        final workerName = trx.worker.name.toLowerCase();
        final toolName = trx.tool.name.toLowerCase();
        return workerName.contains(query) || toolName.contains(query);
      }).toList();
    });
  }

  Future<void> _loadWorkerSuggestions(AppDatabase db) async {
    final workers = await db.getAllWorkers();
    nameToHrMap = {for (var w in workers) w.name: w.hrCode};
    hrToNameMap = {for (var w in workers) w.hrCode: w.name};
    setState(() {});
  }

  void _showWorkerSelectionDialog(
    BuildContext context,
    ScaffoldMessengerState messenger,
  ) async {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    await _loadWorkerSuggestions(db);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Select Worker"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return nameToHrMap.keys.where(
                    (name) => name.toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    ),
                  );
                },
                onSelected: (String selection) {
                  nameController.text = selection;
                  hrCodeController.text = nameToHrMap[selection] ?? '';
                },
                fieldViewBuilder:
                    (context, controller, focusNode, onEditingComplete) {
                      nameController = controller;
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          labelText: 'Search by Name',
                        ),
                      );
                    },
              ),
              const SizedBox(height: 10),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return hrToNameMap.keys.where(
                    (code) => code.toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    ),
                  );
                },
                onSelected: (String selection) {
                  hrCodeController.text = selection;
                  nameController.text = hrToNameMap[selection] ?? '';
                },
                fieldViewBuilder:
                    (context, controller, focusNode, onEditingComplete) {
                      hrCodeController = controller;
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          labelText: 'Search by HR Code',
                        ),
                      );
                    },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();

                final name = nameController.text.trim().toLowerCase();
                final selectedWorker = await db.getWorkerByName(name);

                if (selectedWorker == null) {
                  messenger.showSnackBar(
                    const SnackBar(content: Text("Worker not found.")),
                  );
                  return;
                }

                final workerTransactions = allTransactions.where((trx) {
                  try {
                    return trx.worker.id == selectedWorker.id;
                  } catch (_) {
                    return false;
                  }
                }).toList();

                if (workerTransactions.isNotEmpty) {
                  await generateWorkerPdf(
                    context,
                    selectedWorker,
                    workerTransactions,
                  );
                } else {
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text("No transactions found for this worker"),
                    ),
                  );
                }
              },
              child: const Text("Generate"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () {
              _showWorkerSelectionDialog(context, messenger);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final trx = filteredTransactions[index];
                return ListTile(
                  title: Text(trx.tool.name),
                  subtitle: Text(
                    '${trx.worker.name} • ${trx.transaction.date}',
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Issue: ${trx.transaction.issue}'),
                      Text('Return: ${trx.transaction.returnQty}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
