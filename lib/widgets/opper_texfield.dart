import 'package:flutter/material.dart';

class OpperTexfield extends StatelessWidget {
  final TextEditingController? textController;
  final String? hintText;
  const OpperTexfield({super.key, this.textController, this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
