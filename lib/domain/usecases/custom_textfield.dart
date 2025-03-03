import 'package:flutter/material.dart';
import 'package:stockaxis/core/constants/app_colors.dart';
import 'package:stockaxis/domain/usecases/custom_image.dart';

class CustomDecoration {
  static InputDecoration inputDecoration(
    context, {
    Widget? icon,
    String? prefixText,
    String? label,
    String? hint,
    TextStyle? hintStyle,
    Widget? suffix,
    bool isCollapsed = false,
    bool isHideBorder = false,
    Color borderColor = Colors.black,
    Color bgColor = Colors.transparent,
    double borderRadius = 12.0,
    double borderWidth = .5,
    EdgeInsetsGeometry contentPadding =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
  }) {
    return InputDecoration(
      isCollapsed: isCollapsed,
      fillColor: bgColor,
      filled: true,
      border: isHideBorder
          ? InputBorder.none
          : _border(borderColor, borderRadius, borderWidth),
      enabledBorder: isHideBorder
          ? InputBorder.none
          : _border(Colors.orange, borderRadius, 1.6),
      focusedBorder: isHideBorder
          ? InputBorder.none
          : _border(Colors.orange, borderRadius, 1.6),
      errorBorder: isHideBorder
          ? InputBorder.none
          : _border(Colors.red, borderRadius, 0.6),
      focusedErrorBorder: isHideBorder
          ? InputBorder.none
          : _border(Colors.red, borderRadius, 0.6),
      prefixIcon: icon ?? _prefixIcon(context, prefixText),
      suffixIcon: suffix,
      labelText: label,
      labelStyle: _labelStyle(context),
      hintText: hint,
      hintStyle: hintStyle ?? _hintStyle(context),
      contentPadding: contentPadding,
    );
  }

  static InputDecoration dropdown(
    context, {
    String? icon,
    String? label,
    bool filled = true,
    TextStyle? hintStyle,
    Color borderColor = Colors.black,
    double borderRadius = 12.0,
    double borderWidth = 2.0,
  }) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: filled,
      border: _border(borderColor, borderRadius, borderWidth),
      enabledBorder: _border(borderColor, borderRadius, borderWidth),
      focusedBorder: _border(borderColor, borderRadius, borderWidth),
      errorBorder: _border(Colors.redAccent, borderRadius, 0.4),
      focusedErrorBorder: _border(Colors.redAccent, borderRadius, 0.4),
      prefixIcon:
          icon != null ? CustomImage(path: icon, height: 16, width: 16) : null,
      labelText: label,
      labelStyle: _labelStyle(context),
      hintText: label,
      hintStyle: hintStyle ?? _hintStyle(context),
    );
  }

  static OutlineInputBorder _border(Color color, double radius, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static Widget? _prefixIcon(context, String? prefixText) {
    if (prefixText == null) return null;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
      child: Text(
        prefixText,
        style: _hintStyle(context),
      ),
    );
  }

  static _labelStyle(context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith();
  }

  static _hintStyle(context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith();
  }
}
