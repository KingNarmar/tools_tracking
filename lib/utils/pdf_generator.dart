import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:tools_tracking/data/app_database.dart';
import 'package:open_file/open_file.dart';

Future<void> generateWorkerPdf(
  BuildContext context,
  Worker worker,
  List<TransactionWithDetails> transactions,
) async {
  try {
    final pdf = pw.Document();
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    // حساب العهدة الحالية
    final Map<String, int> currentTools = {};
    for (var trx in transactions) {
      final toolName = trx.tool.name;
      currentTools[toolName] =
          (currentTools[toolName] ?? 0) +
          trx.transaction.issue -
          trx.transaction.returnQty;
    }

    final toolsInHand = currentTools.entries
        .where((entry) => entry.value > 0)
        .map((e) => {'name': e.key, 'qty': e.value})
        .toList();

    // ترتيب الترانزاكشنز حسب التاريخ من الأحدث للأقدم
    transactions.sort(
      (a, b) => b.transaction.date.compareTo(a.transaction.date),
    );

    // اختيار آخر 5 فقط
    final recentTransactions = transactions.take(5).toList();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Worker Report - ${worker.name}',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                style: pw.TextStyle(fontSize: 12),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Text('HR Code: ${worker.hrCode}'),
          pw.Text('Department: ${worker.department}'),
          pw.Text('Job Title: ${worker.jobTitle}'),
          pw.SizedBox(height: 10),

          pw.Text(
            'Last 5 Transactions:',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.Table.fromTextArray(
            headers: ['ID', 'Date', 'Tool', 'Type', 'Qty', 'Unit'],
            data: recentTransactions.map((trx) {
              final isIssue = trx.transaction.issue > 0;
              final qty = isIssue
                  ? trx.transaction.issue
                  : trx.transaction.returnQty;
              return [
                trx.transaction.transactionId,
                dateFormat.format(trx.transaction.date.toLocal()),
                trx.tool.name,
                isIssue ? 'Issue' : 'Return',
                qty.toString(),
                trx.tool.unit,
              ];
            }).toList(),
          ),

          pw.SizedBox(height: 20),
          pw.Text(
            'Tools still in possession:',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          toolsInHand.isNotEmpty
              ? pw.Table.fromTextArray(
                  headers: ['Tool', 'Quantity'],
                  data: toolsInHand
                      .map((e) => [e['name'], e['qty'].toString()])
                      .toList(),
                )
              : pw.Text('No tools currently in possession.'),

          pw.SizedBox(height: 30),
          pw.Text(
            'Declaration:',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            'I acknowledge that I have received the listed equipment in good condition and understand the following terms:\n'
            '1- I must return the equipment directly to the warehouse, not to any other person.\n'
            '2- I am responsible for obtaining official confirmation from the warehouse upon return.\n'
            '3- Transferring equipment between workers is strictly prohibited and can only be done through the warehouse.\n\n'
            'Date: ____ / ____ / 20__\n\n'
            'Name: ___________________________\n\n'
            'Employee ID / HR Code: ____________\n\n'
            'Signature: ______________________',
            textAlign: pw.TextAlign.justify,
          ),
        ],
      ),
    );

    final output = await getApplicationDocumentsDirectory();
    final fileName =
        'worker_report_${worker.name.replaceAll(" ", "_")}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('PDF generated successfully')));

    await OpenFile.open(file.path);
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error generating PDF: $e')));
    print("PDF generation error: $e");
  }
}
