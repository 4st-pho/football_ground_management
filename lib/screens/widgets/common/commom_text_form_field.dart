import 'package:flutter/material.dart';
import 'package:football_ground_management/constant/app_text_style.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? ontap;
  final String lable;

  const CommonTextFormField({
    super.key,
    required this.lable,
    this.ontap,
    this.controller,
    this.readOnly = true,
  });

  @override
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blue, width: 2),
      borderRadius: BorderRadius.circular(10),
    );
    return TextFormField(
      controller: controller,
      onTap: ontap,
      validator: (value) {
        if ((value ?? '').isEmpty) return '$lable không được bỏ trống';
        return null;
      },
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        labelText: lable,
        border: borderStyle,
        errorBorder: borderStyle,
        enabledBorder: borderStyle,
        disabledBorder: borderStyle,
        focusedBorder: borderStyle,
        focusedErrorBorder: borderStyle,
        labelStyle: AppTextStyle.blue15,
      ),
    );
  }
}
