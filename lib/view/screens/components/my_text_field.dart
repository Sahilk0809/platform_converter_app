import 'package:flutter/material.dart';
import 'package:platform_converter_app/provider/theme_controller.dart';
import 'package:provider/provider.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? textInputType;

  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: (Provider.of<ThemeController>(context).isDark)
                ? Colors.white
                : Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }
}
