//lib\widgets\tool_search_bar.dart

import 'package:flutter/material.dart';

class ToolSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const ToolSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Search by tool name',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
