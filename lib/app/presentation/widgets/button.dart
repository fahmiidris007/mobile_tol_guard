import 'package:flutter/material.dart';
import 'package:mobile_tol_guard/core/util/app_theme.dart';

class Button extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final double? textSize;

  final double? width;
  final double? height;
  final bool disabled;
  final double radius;
  final Color? color;
  final Color? textColor;
  final Widget? leading;
  final Widget? trailing;

  const Button(
      {super.key,
      required this.onPressed,
      this.text = '',
      this.width,
      this.height = 52,
      this.disabled = false,
      this.radius = 26,
      this.color,
      this.textColor,
      this.leading,
      this.trailing,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: disabled ? AppTheme.black20 : color,
        borderRadius: BorderRadius.circular(radius),
        gradient:
            disabled ? null : (color != null ? null : AppTheme.gradientViolet),
      ),
      child: FilledButton(
        onPressed: disabled ? () {} : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) leading!,
              Text(
                text,
                style: AppTheme.button(
                    size: textSize ?? 16,
                    color: disabled ? AppTheme.black40 : textColor),
                textAlign: TextAlign.center,
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
