import 'package:flutter/material.dart';
import 'package:tools_tracking/pages/reports_page.dart';
import 'package:tools_tracking/pages/tools_page.dart';
import 'package:tools_tracking/pages/workers_page.dart';

import 'transactions_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tools Tracking System")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildMenuItem(
            context,
            icon: Icons.people,
            label: 'Manage Workers',
            page: const WorkersPage(),
          ),
          const SizedBox(height: 16),
          _buildMenuItem(
            context,
            icon: Icons.build,
            label: 'Manage Tools',
            page: const ToolsPage(),
          ),
          const SizedBox(height: 16),
          _buildMenuItem(
            context,
            icon: Icons.swap_horiz,
            label: 'Transactions',
            page: const TransactionsPage(),
          ),
          const SizedBox(height: 16),
          _buildMenuItem(
            context,
            icon: Icons.swap_horiz,
            label: 'Reports',
            page: const ReportsPage(),
          ),

          // تقدر تضيف صفحات تانية هنا
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget page,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      icon: Icon(icon, size: 28),
      label: Text(label, style: const TextStyle(fontSize: 18)),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
    );
  }
}
