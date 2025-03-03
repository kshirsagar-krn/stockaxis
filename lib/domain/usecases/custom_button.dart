import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

enum ButtonType { fillButton, outlineButton, onlyText }

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final bool isDisable;
  final ButtonType buttonType;
  final double? width;
  final String buttonText;
  final double? textFontSize;
  final Color? textColor;
  final Color? bckColor;
  final List<Color> colors;
  final double? buttonRadius;
  final Widget? child;
  final Function() onClick;

  CustomButton({
    super.key,
    this.isLoading = false,
    this.isDisable = false,
    required this.buttonText,
    required this.onClick,
    this.width,
    this.textFontSize,
    this.textColor,
    this.bckColor,
    this.child,
    this.buttonRadius,
    this.buttonType = ButtonType.fillButton,
    this.colors = const [],
  });

  @override
  Widget build(BuildContext context) {
    // Common Container properties for all button types
    final containerDecoration = BoxDecoration(
      color: buttonType == ButtonType.fillButton
          ? isDisable ? Colors.grey.shade400 :  (bckColor ?? AppColors.primary)
          : Colors.transparent,
      gradient: colors.isNotEmpty
          ? LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: colors)
          : null,
      border: buttonType == ButtonType.outlineButton
          ? Border.all(width: 1, color: Colors.black38)
          : null,
      borderRadius: BorderRadius.circular(buttonRadius ?? 4),
    );

    final textStyle = Theme.of(context).textTheme.labelMedium!.copyWith(
          fontSize: textFontSize ?? 14,
          color: textColor ??
              (buttonType == ButtonType.fillButton
                  ? isDisable ? Colors.grey.shade800 :  Colors.white
                  : Colors.black87),
        );

    // Common Text widget for all button types
    final buttonTextWidget = isLoading ? const SizedBox(
      height: 20, width: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary,)) : Text(
      buttonText,
      textAlign: TextAlign.center,
      style: textStyle,
    );

    return GestureDetector(
      onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        width: width,
        decoration: containerDecoration,
        child: child ?? buttonTextWidget,
      ),
    );
  }
}
