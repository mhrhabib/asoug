import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.validator,
    this.readOnly,
  });

  final Alignment? alignment;
  final double? width;
  final TextEditingController? scrollPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final bool? readOnly;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
          controller: controller,
          focusNode: focusNode ?? FocusNode(),
          style: textStyle ?? CustomTextStyle.bodyLargeff,
          obscureText: obscureText!,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          readOnly: readOnly ?? false,
          validator: validator ??
              (val) {
                if (val == null || val.isEmpty) {
                  return "validator_form_empty_field_not_accepted".tr;
                }
                return null;
              },
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ??
            CustomTextStyle.bodyLargeff.copyWith(
              color: Colors.grey.shade600,
            ),
        prefixIcon: prefix != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: IconTheme(
                  data: IconThemeData(
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  child: prefix!,
                ),
              )
            : null,
        prefixIconConstraints: prefixConstraints ??
            const BoxConstraints(
              minWidth: 24,
              minHeight: 24,
            ),
        suffixIcon: suffix != null
            ? Padding(
                padding: const EdgeInsets.only(right: 12, left: 8),
                child: IconTheme(
                  data: IconThemeData(
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  child: suffix!,
                ),
              )
            : null,
        suffixIconConstraints: suffixConstraints ??
            const BoxConstraints(
              minWidth: 24,
              minHeight: 24,
            ),
        isDense: true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
        fillColor: fillColor ?? Colors.white,
        filled: filled ?? true,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.green.shade300,
                width: 1.5,
              ),
            ),
        errorBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.error,
                width: 1.0,
              ),
            ),
        focusedErrorBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.error,
                width: 1.5,
              ),
            ),
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static UnderlineInputBorder get underLinePurple => UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.purple.shade300,
        ),
      );
  static OutlineInputBorder get fillOnErrorContainer => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      );
  static UnderlineInputBorder get underLineGray => UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade50,
        ),
      );
  static UnderlineInputBorder get underLineBlueGray => UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueGrey.shade300,
        ),
      );
}

class CustomTextStyle {
  static get bodyLargeff => Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
        color: const Color(0XFF333333),
        fontWeight: FontWeight.w400,
      );
}
