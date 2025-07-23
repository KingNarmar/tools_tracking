import 'package:flutter/material.dart';
import 'package:tools_tracking/widgets/worker_search_bar.dart';

class ManageWorkerTap extends StatefulWidget {
  const ManageWorkerTap({super.key});

  @override
  State<ManageWorkerTap> createState() => _ManageWorkerTapState();
}

class _ManageWorkerTapState extends State<ManageWorkerTap> {
  final TextEditingController _searchController = TextEditingController();
  SearchMode _searchMode = SearchMode.name;

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
          Text("Workers Table"),
        ],
      ),
    );
  }
}

enum SearchMode { name, hrCode }
