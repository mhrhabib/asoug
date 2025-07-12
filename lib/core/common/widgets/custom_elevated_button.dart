import 'package:flutter/material.dart';
import 'base_button.dart';
import 'custom_text_form_field.dart';

class CustomElevatedButton extends BaseButton {
  const CustomElevatedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    required super.text,
    this.elevation = 0,
    this.loading = false,
  });

  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final double elevation;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
        height: height ?? 48,
        width: width ?? double.maxFinite,
        margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
        decoration: decoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                if (elevation > 0)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
        child: ElevatedButton(
          style: buttonStyle ??
              ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1877F2), // Facebook blue
                foregroundColor: Colors.white,
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
          onPressed: (isDisabled ?? false) || loading ? null : onPressed ?? () {},
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (loading)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  )
                else if (leftIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: leftIcon!,
                  ),
                Text(
                  text,
                  style: buttonTextStyle ??
                      CustomTextStyle.bodyLargeff.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                ),
                if (rightIcon != null && !loading)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: rightIcon!,
                  ),
              ],
            ),
          ),
        ),
      );
}
