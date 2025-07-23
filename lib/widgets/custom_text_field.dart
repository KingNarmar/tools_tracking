import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (suggestions != null && onSelected != null) {
      return Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty)
            return const Iterable<String>.empty();

          return suggestions!.where(
            (option) => option.toLowerCase().contains(
              textEditingValue.text.toLowerCase(),
            ),
          );
        },
        onSelected: (String val) {
          controller.text = val;
          onSelected?.call(val); // في حالة لو الصفحة نفسها عايزة تتصرف كمان
        },
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
              textEditingController.addListener(() {
                if (controller.text != textEditingController.text) {
                  controller.text = textEditingController.text;
                }
              });
              controller.addListener(() {
                if (textEditingController.text != controller.text) {
                  textEditingController.text = controller.text;
                }
              });
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  focusNode: focusNode,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onSubmitted: (_) {
                    controller.text = textEditingController.text;
                  },
                ),
              );
            },
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
