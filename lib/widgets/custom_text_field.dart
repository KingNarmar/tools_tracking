import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;

  // Autocomplete Variables
  final List<String>? suggestions;
  final void Function(String)? onSelected;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.suggestions,
    this.onSelected,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = TextEditingController(text: widget.controller.text);

    // Sync internal controller with external
    _internalController.addListener(_syncToExternal);
    widget.controller.addListener(_syncFromExternal);
  }

  void _syncToExternal() {
    if (widget.controller.text != _internalController.text) {
      widget.controller.text = _internalController.text;
    }
  }

  void _syncFromExternal() {
    if (_internalController.text != widget.controller.text) {
      _internalController.text = widget.controller.text;
    }
  }

  @override
  void dispose() {
    _internalController.removeListener(_syncToExternal);
    widget.controller.removeListener(_syncFromExternal);
    _internalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.suggestions != null && widget.onSelected != null) {
      return Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }

          return widget.suggestions!.where(
            (option) => option.toLowerCase().contains(
              textEditingValue.text.toLowerCase(),
            ),
          );
        },
        onSelected: (String val) {
          widget.controller.text = val;
          widget.onSelected?.call(val);
        },
        fieldViewBuilder: (context, textEditingController, focusNode, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              focusNode: focusNode,
              controller: _internalController,
              decoration: InputDecoration(
                hintText: widget.hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSubmitted: (_) {
                widget.controller.text = _internalController.text;
              },
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
