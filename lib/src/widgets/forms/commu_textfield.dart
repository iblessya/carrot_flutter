import 'package:flutter/material.dart';

class CommuTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final double fontSize;
  final int? maxLines;

  const CommuTextField({
    required this.controller,
    this.hint,
    this.fontSize = 14,
    this.maxLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle().copyWith(fontSize: fontSize),
      maxLines: maxLines,
      expands: (maxLines == null),
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle().copyWith(fontSize: fontSize),
        hintMaxLines: 2,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
