import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools_tracking/data/app_database.dart';
import 'package:tools_tracking/data/database_provider.dart';
import 'package:tools_tracking/widgets/tool_search_bar.dart';
import 'package:tools_tracking/widgets/tools_table.dart';
import 'package:tools_tracking/widgets/add_edit_tool_form.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Tool> _tools = [];

  @override
  void initState() {
    super.initState();
    _loadTools();
    _searchController.addListener(_loadTools);
  }

  Future<void> _loadTools() async {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    final allTools = await db.select(db.tools).get();
    final query = _searchController.text.toLowerCase().trim();

    final filtered = allTools.where((tool) {
      return tool.name.toLowerCase().contains(query);
    }).toList();

    setState(() {
      _tools = filtered;
    });
  }

  Future<void> _deleteTool(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this tool?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (!mounted || confirmed != true) return;

    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    await (db.delete(db.tools)..where((t) => t.id.equals(id))).go();
    await _loadTools();
  }

  void _openAddEditForm({Tool? tool}) {
    showDialog(
      context: context,
      builder: (_) => AddEditToolForm(
        existingTool: tool,
        onSaved: () async => await _loadTools(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Tools")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ToolSearchBar(controller: _searchController),
            const SizedBox(height: 16),
            Expanded(
              child: ToolsTable(
                tools: _tools,
                onEdit: (tool) => _openAddEditForm(tool: tool),
                onDelete: _deleteTool,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openAddEditForm();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
