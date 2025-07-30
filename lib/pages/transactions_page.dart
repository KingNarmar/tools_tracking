import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools_tracking/data/app_database.dart';
import 'package:tools_tracking/data/database_provider.dart';
import 'package:tools_tracking/widgets/add_edit_transaction_form.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  List<TransactionWithDetails> transactions = [];
  TextEditingController _searchController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    final data = await db.getAllTransactionsWithDetails();
    setState(() => transactions = data);
  }

  void _applyFilters() async {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    final data = await db.getAllTransactionsWithDetails();

    final query = _searchController.text.trim().toLowerCase();

    final filtered = data.where((trx) {
      final matchSearch =
          trx.worker.name.toLowerCase().contains(query) ||
          trx.tool.name.toLowerCase().contains(query);

      final matchStart =
          _startDate == null ||
          trx.transaction.date.isAfter(
            _startDate!.subtract(const Duration(days: 1)),
          );
      final matchEnd =
          _endDate == null ||
          trx.transaction.date.isBefore(_endDate!.add(const Duration(days: 1)));

      return matchSearch && matchStart && matchEnd;
    }).toList();

    setState(() => transactions = filtered);
  }

  Future<void> _deleteTransaction(int id) async {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    await (db.delete(db.transactionsTable)..where((t) => t.id.equals(id))).go();
    await _loadTransactions();
  }

  void _confirmDelete(BuildContext context, int id) {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Confirmation"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Please Contact MR.Mina (+971581255496)"),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Enter Password",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (passwordController.text.trim() == "1234") {
                Navigator.of(context).pop();
                _deleteTransaction(id);
              } else {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Incorrect password")),
                );
              }
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  void _openAddForm() {
    showDialog(
      context: context,
      builder: (_) => AddEditTransactionForm(onSaved: _loadTransactions),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transactions")),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddForm,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: "Search by Worker or Tool",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _applyFilters(),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().subtract(
                              const Duration(days: 30),
                            ),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() => _startDate = picked);
                            _applyFilters();
                          }
                        },
                        child: Text(
                          _startDate == null
                              ? "Start Date"
                              : "From: ${_startDate!.toLocal()}".split(' ')[0],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() => _endDate = picked);
                            _applyFilters();
                          }
                        },
                        child: Text(
                          _endDate == null
                              ? "End Date"
                              : "To: ${_endDate!.toLocal()}".split(' ')[0],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: transactions.isEmpty
                ? const Center(child: Text("No transactions yet"))
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final trx = transactions[index];
                      final imagePath = trx.transaction.issue > 0
                          ? trx.transaction.issueImagePath
                          : trx.transaction.returnImagePath;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: imagePath != null && imagePath.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                        child: InteractiveViewer(
                                          child: Image.file(File(imagePath)),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.file(
                                    File(imagePath),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.broken_image),
                                  ),
                                )
                              : const Icon(Icons.image_not_supported),
                          title: Text("${trx.worker.name} - ${trx.tool.name}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Qty: ${trx.transaction.issue > 0 ? trx.transaction.issue : trx.transaction.returnQty} ${trx.tool.unit}",
                              ),
                              Text(
                                "Type: ${trx.transaction.issue > 0 ? 'Issue' : 'Return'}",
                              ),
                              Text("Date: ${trx.transaction.date.toLocal()}"),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _confirmDelete(context, trx.transaction.id),
                          ),
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
