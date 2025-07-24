import 'package:flutter/material.dart';
import 'package:tools_tracking/widgets/manage_worker_tap.dart';

class WorkerSearchBar extends StatelessWidget {
  final SearchMode searchType; // "name" or "hr"
  final ValueChanged<SearchMode?> onSearchTypeChanged;
  final TextEditingController searchController;
  final List<String> allWorkerNames;

  const WorkerSearchBar({
    super.key,
    required this.searchType,
    required this.onSearchTypeChanged,
    required this.searchController,
    required this.allWorkerNames,
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
          child: Autocomplete<String>(
            key: ValueKey(allWorkerNames.join()),
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return allWorkerNames.where((String option) {
                return option.toLowerCase().contains(
                  textEditingValue.text.toLowerCase(),
                );
              });
            },
            onSelected: (String selection) {
              searchController.text = selection;
            },
            fieldViewBuilder:
                (context, controller, focusNode, onFieldSubmitted) {
                  return TextField(
                    controller: searchController,
                    focusNode: focusNode,
                    onSubmitted: (_) => onFieldSubmitted(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search...",
                      border: OutlineInputBorder(),
                    ),
                  );
                },
          ),
        ),
      ],
    );
  }
}
