import 'package:flutter/material.dart';
import 'opper_colors.dart';

class OpperTextfield extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode? focusNode;
  final String hintText;
  final Color backgroundColor;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry contentPadding;

  const OpperTextfield({
    super.key,
    required this.textController,
    this.focusNode,
    this.hintText = "",
    this.backgroundColor = OpperColors.unselected,
    this.hintStyle,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: textController,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyle(
                color: focusNode?.hasFocus == true
                    ? Colors.transparent
                    : Colors.white.withAlpha(180),
              ),
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onTap: () {},
        onEditingComplete: () {
          focusNode?.unfocus();
        },
      ),
    );
  }
}
