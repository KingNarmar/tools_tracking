import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools_tracking/data/app_database.dart';
import 'package:tools_tracking/data/database_provider.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<TransactionWithDetails> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    final data = await db.getAllTransactionsWithDetails();
    setState(() => transactions = data);
  }

  @override
  Widget build(BuildContext context) {
    int totalIssues = transactions.fold(
      0,
      (sum, trx) => sum + trx.transaction.issue,
    );
    int totalReturns = transactions.fold(
      0,
      (sum, trx) => sum + trx.transaction.returnQty,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Reports")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: transactions.isEmpty
            ? const Center(child: Text("No data"))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("📦 Total Issued: $totalIssues"),
                  Text("📥 Total Returned: $totalReturns"),
                  const SizedBox(height: 20),
                  const Text(
                    "🔍 Most Active Workers and Tools - coming soon...",
                  ),
                ],
              ),
      ),
    );
  }
}
