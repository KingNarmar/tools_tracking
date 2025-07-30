import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools_tracking/data/app_database.dart';
import 'package:tools_tracking/data/database_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart' as drift;

class AddEditTransactionForm extends StatefulWidget {
  final VoidCallback onSaved;

  const AddEditTransactionForm({super.key, required this.onSaved});

  @override
  State<AddEditTransactionForm> createState() => _AddEditTransactionFormState();
}

class _AddEditTransactionFormState extends State<AddEditTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _workerController = TextEditingController();
  final _toolController = TextEditingController();
  final _quantityController = TextEditingController();
  String? _unit;
  File? _selectedImage;
  bool _isIssue = true;

  List<String> workerSuggestions = [];
  List<String> toolSuggestions = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() => _selectedImage = File(result.path));
    }
  }

  Future<void> fetchWorkerSuggestions(String query) async {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    final results = await db.getWorkersByPartialName(query);
    setState(() {
      workerSuggestions = results.map((w) => w.name).toList();
    });
  }

  Future<void> fetchToolSuggestions(String query) async {
    final db = Provider.of<DatabaseProvider>(context, listen: false).database;
    final results = await db.getToolsByPartialName(query);
    setState(() {
      toolSuggestions = results.map((t) => t.name).toList();
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    if (_isIssue && _selectedImage == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Image required for issue transaction")),
      );
      return;
    }

    final db = Provider.of<DatabaseProvider>(context, listen: false).database;

    final workerName = _workerController.text.trim();
    final toolName = _toolController.text.trim();
    final qty = int.tryParse(_quantityController.text.trim());

    final worker = await db.getWorkerByName(workerName);
    final tool = await db.getToolByName(toolName);

    if (!mounted) return;

    if (worker == null || tool == null || qty == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid input")));
      return;
    }

    if (!_isIssue) {
      final currentQty = await db.getWorkerToolBalance(worker.id, tool.id);
      if (!mounted) return;
      if (qty > currentQty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Cannot return more than current balance: $currentQty",
            ),
          ),
        );
        return;
      }
    }

    final trxId = await db.generateNextTransactionId();
    final now = DateTime.now();
    final imagePath = _selectedImage?.path;

    await db.insertTransaction(
      TransactionsTableCompanion(
        transactionId: drift.Value(trxId),
        date: drift.Value(now),
        workerId: drift.Value(worker.id),
        toolId: drift.Value(tool.id),
        issue: _isIssue ? drift.Value(qty) : const drift.Value.absent(),
        returnQty: !_isIssue ? drift.Value(qty) : const drift.Value.absent(),
        issueImagePath: _isIssue
            ? (imagePath != null
                  ? drift.Value(imagePath)
                  : const drift.Value.absent())
            : const drift.Value(null),

        returnImagePath: !_isIssue && imagePath != null
            ? drift.Value(imagePath)
            : const drift.Value(null),
      ),
    );

    if (!mounted) return;
    Navigator.of(context).pop();
    widget.onSaved();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("New Transaction"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  await fetchWorkerSuggestions(textEditingValue.text);
                  return workerSuggestions;
                },
                fieldViewBuilder:
                    (context, controller, focusNode, onFieldSubmitted) {
                      _workerController.text = controller.text;
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          labelText: "Worker Name",
                        ),
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? "Required" : null,
                      );
                    },
                onSelected: (String selection) {
                  _workerController.text = selection;
                },
              ),
              const SizedBox(height: 10),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  await fetchToolSuggestions(textEditingValue.text);
                  return toolSuggestions;
                },
                fieldViewBuilder:
                    (context, controller, focusNode, onFieldSubmitted) {
                      _toolController.text = controller.text;
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          labelText: "Tool Name",
                        ),
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? "Required" : null,
                        onChanged: (val) async {
                          final db = Provider.of<DatabaseProvider>(
                            context,
                            listen: false,
                          ).database;
                          final tool = await db.getToolByName(val.trim());
                          if (tool != null) {
                            setState(() => _unit = tool.unit);
                          }
                        },
                      );
                    },
                onSelected: (String selection) async {
                  _toolController.text = selection;
                  final db = Provider.of<DatabaseProvider>(
                    context,
                    listen: false,
                  ).database;
                  final tool = await db.getToolByName(selection);
                  if (tool != null) {
                    setState(() => _unit = tool.unit);
                  }
                },
              ),
              if (_unit != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text("Unit: $_unit"),
                ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      value: true,
                      groupValue: _isIssue,
                      title: const Text("Issue"),
                      onChanged: (val) => setState(() => _isIssue = val!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      value: false,
                      groupValue: _isIssue,
                      title: const Text("Return"),
                      onChanged: (val) => setState(() => _isIssue = val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: Text(
                  _selectedImage == null ? "Pick Image" : "Image Selected",
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(onPressed: _save, child: const Text("Save")),
      ],
    );
  }
}
