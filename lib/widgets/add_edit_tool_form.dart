import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools_tracking/data/app_database.dart';
import 'package:tools_tracking/data/database_provider.dart';

class AddEditToolForm extends StatefulWidget {
  final Tool? existingTool;
  final VoidCallback onSaved;

  const AddEditToolForm({super.key, this.existingTool, required this.onSaved});

  @override
  State<AddEditToolForm> createState() => _AddEditToolFormState();
}

class _AddEditToolFormState extends State<AddEditToolForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedUnit = 'Each';

  final List<String> _units = ['Each', 'KG', 'MTR'];

  @override
  void initState() {
    super.initState();
    if (widget.existingTool != null) {
      _nameController.text = widget.existingTool!.name;
      _selectedUnit = widget.existingTool!.unit;
    }
  }

  Future<void> _saveTool() async {
    if (!_formKey.currentState!.validate()) return;

    final db = Provider.of<DatabaseProvider>(context, listen: false).database;

    // تنظيف الاسم: إزالة الفراغات الزائدة وتحويله لحروف صغيرة
    final cleanName = _nameController.text.trim().toLowerCase().replaceAll(
      RegExp(r'\s+'),
      ' ',
    );

    if (widget.existingTool != null) {
      // في حالة التعديل: تأكد إن الاسم الجديد مش مكرر عند أداة تانية
      final existing = await db.getToolByName(cleanName);
      if (existing != null && existing.id != widget.existingTool!.id) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Another tool with this name already exists'),
          ),
        );
        return;
      }

      // لو مفيش تكرار، يتم التحديث
      await db.updateTool(
        Tool(
          id: widget.existingTool!.id,
          toolId: widget.existingTool!.toolId,
          name: cleanName,
          unit: _selectedUnit,
        ),
      );
    } else {
      // في حالة الإضافة: تأكد إن الاسم مش موجود خالص
      final existing = await db.getToolByName(cleanName);
      if (existing != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This tool already exists')),
        );
        return;
      }

      final newId = await db.generateNextToolId();
      await db.insertTool(
        ToolsCompanion(
          toolId: Value(newId),
          name: Value(cleanName),
          unit: Value(_selectedUnit),
        ),
      );
    }

    if (mounted) {
      Navigator.of(context).pop();
      widget.onSaved();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingTool != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Tool' : 'Add Tool'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Tool Name'),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedUnit,
              items: _units
                  .map(
                    (unit) => DropdownMenuItem(value: unit, child: Text(unit)),
                  )
                  .toList(),
              onChanged: (val) => setState(() => _selectedUnit = val!),
              decoration: const InputDecoration(labelText: 'Unit'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveTool,
          child: Text(isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}
