import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Translucent capsule pill container for luxury tier badges and status indicators
class GlassPill extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  const GlassPill({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.backgroundColor,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget pill = ClipRRect(
      borderRadius: BorderRadius.circular(9999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.glassPill,
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(
              color: borderColor ?? AppColors.borderSubtle,
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      pill = GestureDetector(
        onTap: onTap,
        child: pill,
      );
    }

    return pill;
  }
}

