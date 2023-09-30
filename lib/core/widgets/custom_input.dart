import 'package:flutter/material.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';

class CustomInput extends StatefulWidget {
  final void Function()? onTap;
  final TextEditingController controller;
  final bool? isObscured;
  final String hintText;
  final Widget? suffix;
  final Color? backgroundColor;
  final bool disabled;

  const CustomInput({
    super.key,
    this.onTap,
    required this.controller,
    this.isObscured,
    required this.hintText,
    this.suffix,
    this.backgroundColor,
    this.disabled = false,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      controller: widget.controller,
      obscureText: widget.isObscured ?? false,
      style: const TextStyle(
        color: AppColors.primaryWhite,
        fontSize: 14,
      ),
      enabled: !widget.disabled,
      cursorColor: AppColors.neutralGray,
      decoration: InputDecoration(
        fillColor: widget.backgroundColor,
        filled: true,
        contentPadding: const EdgeInsets.only(left: 10),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: AppColors.neutralGray,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryGray),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryGray),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryGray),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: widget.suffix,
      ),
    );
  }
}
