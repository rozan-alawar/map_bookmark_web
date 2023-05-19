import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/styles/color_manager.dart';
import '../../utils/styles/styles_manager.dart';

class CommonTextField extends ConsumerWidget {
  const CommonTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.isPassword = false,
    this.validator,
    this.prefix,
    this.suffix,
    this.initialValue,
    this.decoration,
    this.fillColor,
    this.style,
    this.width = 500,
    this.onSaved,
    this.onChanged,
  });

  final String? hintText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final String? initialValue;
  final InputDecoration? decoration;
  final TextStyle? style;
  final Color? fillColor;
  final void Function()? onSaved;
  final void Function(String?)? onChanged;
  final double width;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      inputFormatters: [LengthLimitingTextInputFormatter(44)],
      initialValue: initialValue,
      key: key,
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      onEditingComplete: onSaved,
      onChanged: onChanged,
      textCapitalization: TextCapitalization.words,
      decoration: decoration ??
          InputDecoration(
            fillColor: fillColor,
            prefix: prefix,
            suffixIcon: suffix,
            hintText: hintText ?? '',
            constraints: BoxConstraints(maxHeight: 80.h, maxWidth: width.w),
            hintStyle: getRegularStyle(
              color: ColorManager.lightBlack,
              fontSize: 14,
            ),
          ),
      style: style ??
          const TextStyle(
            color: ColorManager.black,
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
          ),
    );
  }
}
