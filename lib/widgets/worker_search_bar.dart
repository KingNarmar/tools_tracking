import 'package:flutter/material.dart';
import 'package:tools_tracking/widgets/manage_worker_tap.dart';

class WorkerSearchBar extends StatelessWidget {
  final SearchMode searchType; // "name" or "hr"
  final ValueChanged<SearchMode?> onSearchTypeChanged;
  final TextEditingController searchController;

  const WorkerSearchBar({
    super.key,
    required this.searchType,
    required this.onSearchTypeChanged,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<SearchMode>(
              value: SearchMode.name,
              groupValue: searchType,
              onChanged: onSearchTypeChanged,
            ),
            const Text("Name"),
            Radio<SearchMode>(
              value: SearchMode.hrCode,
              groupValue: searchType,
              onChanged: onSearchTypeChanged,
            ),
            const Text("HR Code"),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search...",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
