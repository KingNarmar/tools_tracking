import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tools_tracking/data/app_database.dart';

class TransactionsTable extends StatelessWidget {
  final List<TransactionWithDetails> transactions;
  final void Function(TransactionWithDetails transaction) onEdit;
  final void Function(TransactionWithDetails transaction) onDelete;

  const TransactionsTable({
    super.key,
    required this.transactions,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(child: Text("No transactions found"));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Tool')),
          DataColumn(label: Text('Worker')),
          DataColumn(label: Text('Issue')),
          DataColumn(label: Text('Return')),
          DataColumn(label: Text('Unit')),
          DataColumn(label: Text('Image')),
          DataColumn(label: Text('Actions')),
        ],
        rows: transactions.map((trx) {
          final imagePath =
              (trx.transaction.issueImagePath != null &&
                  trx.transaction.issueImagePath!.isNotEmpty)
              ? trx.transaction.issueImagePath
              : trx.transaction.returnImagePath;

          final imageWidget = DataCell(
            Row(
              children: [
                if (imagePath != null && imagePath.isNotEmpty)
                  Image.file(
                    File(imagePath),
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.image_not_supported),
                  ),
                IconButton(
                  icon: const Icon(Icons.zoom_in),
                  tooltip: 'View Image',
                  onPressed: imagePath != null && imagePath.isNotEmpty
                      ? () {
                          print('Image path: \$imagePath');
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              child: InteractiveViewer(
                                child: Image.file(File(imagePath)),
                              ),
                            ),
                          );
                        }
                      : null,
                ),
              ],
            ),
          );

          return DataRow(
            cells: [
              DataCell(Text(trx.transaction.transactionId)),
              DataCell(Text(trx.transaction.date.toString())),
              DataCell(Text(trx.tool.name)),
              DataCell(Text(trx.worker.name)),
              DataCell(Text(trx.transaction.issue.toString())),
              DataCell(Text(trx.transaction.returnQty.toString())),
              DataCell(Text(trx.tool.unit)),
              imageWidget,
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => onEdit(trx),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => onDelete(trx),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
