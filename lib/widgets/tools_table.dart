import 'package:flutter/material.dart';
import 'package:tools_tracking/data/app_database.dart';

class ToolsTable extends StatelessWidget {
  final List<Tool> tools;
  final void Function(Tool tool) onEdit;
  final void Function(int id) onDelete;

  const ToolsTable({
    super.key,
    required this.tools,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return tools.isEmpty
        ? const Center(child: Text('No tools found'))
        : ListView.separated(
            itemCount: tools.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final tool = tools[index];
              return ListTile(
                leading: Text(
                  tool.toolId,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                title: Text(tool.name),
                subtitle: Text('Unit: ${tool.unit}'),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => onEdit(tool),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => onDelete(tool.id),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
