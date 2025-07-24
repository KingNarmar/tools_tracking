import 'package:flutter/material.dart';

class WorkersTable extends StatelessWidget {
  final List<Map<String, dynamic>> workers;
  final void Function(Map<String, dynamic>) onEdit;
  final void Function(int) onDelete;
  const WorkersTable({
    super.key,
    required this.workers,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(label: Text("ID")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("HR Code")),
            DataColumn(label: Text("Department")),
            DataColumn(label: Text("Job Title")),
            DataColumn(label: Text("Actions")),
          ],
          rows: workers.map((worker) {
            return DataRow(
              cells: [
                DataCell(Text(worker['id'].toString())),
                DataCell(Text(worker['name'] ?? '')),
                DataCell(Text(worker['hrCode'] ?? '')),
                DataCell(Text(worker['department'] ?? '')),
                DataCell(Text(worker['jobTitle'] ?? '')),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // تعديل العامل
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => onDelete(worker['id']),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
