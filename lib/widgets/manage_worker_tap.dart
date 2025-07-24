import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools_tracking/data/database_provider.dart';

import 'package:tools_tracking/widgets/worker_search_bar.dart';
import 'package:tools_tracking/widgets/workers_table.dart';

class ManageWorkerTap extends StatefulWidget {
  const ManageWorkerTap({super.key});

  @override
  State<ManageWorkerTap> createState() => _ManageWorkerTapState();
}

class _ManageWorkerTapState extends State<ManageWorkerTap> {
  final TextEditingController _searchController = TextEditingController();
  SearchMode _searchMode = SearchMode.name;
  final List<Map<String, dynamic>> _workers = [];

  @override
  void initState() {
    super.initState();
    _loadWorkers();
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
            searchType: _searchMode,
            onSearchTypeChanged: (value) {
              if (value != null) {
                setState(() {
                  _searchMode = value;
                });
              }
            },
            searchController: _searchController,
          ),

          SizedBox(height: 20),
          WorkersTable(workers: _workers),
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
}

enum SearchMode { name, hrCode }
