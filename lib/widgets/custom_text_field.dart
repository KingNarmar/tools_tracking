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
        onSelected: onSelected!,
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
              controller.addListener(() {
                if (controller.text != textEditingController.text) {
                  textEditingController.text = controller.text;
                  textEditingController.selection = controller.selection;
                }
              });

              textEditingController.addListener(() {
                if (textEditingController.text != controller.text) {
                  controller.text = textEditingController.text;
                  controller.selection = textEditingController.selection;
                }
              });
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  focusNode: focusNode,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
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
