import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools_tracking/data/database_provider.dart';
import 'package:tools_tracking/widgets/edit_worker_form.dart';

import 'package:tools_tracking/widgets/worker_search_bar.dart';
import 'package:tools_tracking/widgets/workers_table.dart';

class ManageWorkerTap extends StatefulWidget {
  final VoidCallback onDataChanged;
  const ManageWorkerTap({super.key, required this.onDataChanged});

  @override
  State<ManageWorkerTap> createState() => _ManageWorkerTapState();
}

class _ManageWorkerTapState extends State<ManageWorkerTap> {
  final TextEditingController _searchController = TextEditingController();
  SearchMode _searchMode = SearchMode.name;
  final List<Map<String, dynamic>> _workers = [];
  List<String> _allWorkerNames = [];

  @override
  void initState() {
    super.initState();
    _loadWorkers();
    _loadWorkerNames();
    _searchController.addListener(_loadWorkers);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WorkerSearchBar(
            key: ValueKey(_allWorkerNames.hashCode),
            searchType: _searchMode,
            onSearchTypeChanged: (value) {
              if (value != null) {
                setState(() {
                  _searchMode = value;
                });
              }
            },
            searchController: _searchController,
            allWorkerNames: _allWorkerNames,
          ),

          SizedBox(height: 20),
          WorkersTable(
            workers: _workers,
            onEdit: _editWorker,
            onDelete: _deleteWorker,
          ),
        ],
      ),
    );
  }

  Future<void> _loadWorkers() async {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    final allWorkers = await db.getAllWorkers();

    final query = _searchController.text.toLowerCase().trim();

    final filteredWorkers = allWorkers.where((w) {
      final target = _searchMode == SearchMode.name
          ? w.name.toLowerCase()
          : w.hrCode.toLowerCase();
      return target.contains(query);
    }).toList();

    setState(() {
      _workers
        ..clear()
        ..addAll(
          filteredWorkers.map(
            (w) => {
              'id': w.id,
              'name': w.name,
              'hrCode': w.hrCode,
              'department': w.department,
              'jobTitle': w.jobTitle,
            },
          ),
        );
    });
  }

  Future<void> _loadWorkerNames() async {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    final names = await db.getAllWorkerNames();
    setState(() {
      _allWorkerNames = names;
    });
  }

  Future<void> _editWorker(Map<String, dynamic> worker) async {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    final id = worker['id'] as int;

    final fullWorker = await (db.select(
      db.workers,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

    if (!mounted || fullWorker == null) return;

    showDialog(
      context: context,
      builder: (_) => EditWorkerForm(
        worker: fullWorker,
        onUpdated: () async {
          await _loadWorkers();
          await _loadWorkerNames();
          widget.onDataChanged();
        },
      ),
    );
  }

  Future<void> _deleteWorker(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this worker?'),
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

    // بعد await لازم تتأكد إن الـ widget لسه موجود
    if (!mounted || confirmed != true) return;

    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    await db.deleteWorker(id);
    await _loadWorkers();
    await _loadWorkerNames();
    widget.onDataChanged();
  }
}

enum SearchMode { name, hrCode }
