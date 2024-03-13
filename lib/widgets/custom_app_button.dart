// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tasker/core/extensions/app_theme_extensions.dart';
import 'package:tasker/core/theme/colors.dart';

///
enum ButtonType {
  ///
  primary,

  ///
  secondary,

  ///
  error,
}

///
class CustomAppButton extends StatelessWidget {
  ///
  const CustomAppButton({
    required this.buttonLabel,
    required this.buttonType,
    this.isLoading = false,
    this.hasIcon = false,
    this.onButtonPressed,
    this.icon,
    super.key,
    this.height,
    this.width,
    this.textStyle,
    this.svgIcon,
  });

  /// Button height
  final double? height;

  /// Button width
  final double? width;

  ///
  final String buttonLabel;

  ///
  final TextStyle? textStyle;

  ///
  final ButtonType buttonType;

  ///
  final VoidCallback? onButtonPressed;

  ///
  final bool isLoading;

  ///
  final bool hasIcon;

  ///
  final IconData? icon;

  ///
  final String? svgIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? () {} : onButtonPressed,
      child: Container(
        width: width ?? 366,
        height: height ?? 60,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: buttonType == ButtonType.primary
              ? context.colorScheme.primary
              : buttonType == ButtonType.error
                  ? Colors.red[700]
                  : const Color(0xffE5E9F0),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Color(0xffE5E9F0),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (hasIcon) ...[
                      Icon(
                        icon,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                    ] else
                      const SizedBox(),
                    Text(
                      buttonLabel,
                      style: textStyle ??
                          context.textTheme.titleSmall?.copyWith(
                            color: buttonType == ButtonType.primary ||
                                    buttonType == ButtonType.error
                                ? Colors.white
                                : primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
