import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_tol_guard/core/util/app_theme.dart';
import 'package:mobile_tol_guard/core/util/layer_size.dart';

class CustomTextField extends StatefulWidget {
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final String? initialValue;
  final String? hint;
  final String? label;
  final double radius;
  final bool obscureText;
  final TextInputType? inputType;
  final bool setUpperCase;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? formatter;
  final bool numberOnly;
  final bool alphanumericOnly;
  final bool readOnly;
  final bool? border;
  final int? maxLength;
  final int? maxLines;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool enableFocusedBorder;
  final Color fillColor;
  final Widget? leading;
  final Widget? trailing;
  final bool? disableSpace;
  final Function()? trailingTap;
  final FocusNode? focusNode;
  final ValueChanged<bool>? isFocused;

  const CustomTextField({
    super.key,
    this.width,
    this.height,
    this.controller,
    this.initialValue,
    this.hint,
    this.label,
    this.radius = 8,
    this.obscureText = false,
    this.inputType,
    this.numberOnly = false,
    this.alphanumericOnly = false,
    this.readOnly = false,
    this.setUpperCase = false,
    this.textAlign,
    this.formatter,
    this.maxLength,
    this.maxLines = 1,
    this.onChanged,
    this.enableFocusedBorder = true,
    this.fillColor = AppTheme.black10,
    this.onTap,
    this.leading,
    this.trailing,
    this.border,
    this.disableSpace = false,
    this.trailingTap,
    this.focusNode,
    this.isFocused,
  });

  @override
  State<StatefulWidget> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focus;
  bool isFocused = false;
  late TextEditingController controller;
  bool isEmpty = true;

  List<TextInputFormatter>? formatter;

  @override
  void initState() {
    _focus = widget.focusNode ?? FocusNode();
    super.initState();
    _focus.addListener(_onFocusChange);
    controller = widget.controller ?? TextEditingController();
    controller.addListener(() {
      isEmpty = controller.text.isEmpty;
    });

    formatter = widget.formatter;
    if (widget.numberOnly) {
      formatter ??= <TextInputFormatter>[];
      formatter!.add(FilteringTextInputFormatter.digitsOnly);
    }
    if (widget.disableSpace ?? false) {
      formatter ??= <TextInputFormatter>[];
      formatter!.add(FilteringTextInputFormatter.deny(RegExp(r'\s')));
    }
    if (widget.alphanumericOnly) {
      formatter ??= <TextInputFormatter>[];
      formatter!.add(FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focus.hasFocus;
      widget.isFocused?.call(isFocused);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width ?? layerWidth,
      height: widget.height ?? 60,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: widget.fillColor,
        borderRadius: BorderRadius.circular(widget.radius),
        border: widget.border == false
            ? Border.all(color: AppTheme.white, width: 2.0)
            : isFocused
                ? Border.all(color: AppTheme.blue50, width: 2.0)
                : Border.all(color: widget.fillColor, width: 2.0),
      ),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.leading != null)
              Flexible(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  child: widget.leading ?? Container(),
                ),
              ),
            Flexible(
              flex: 1,
              child: TextFormField(
                focusNode: _focus,
                controller: controller,
                initialValue: widget.initialValue,
                textAlign: widget.textAlign ?? TextAlign.left,
                onTap: widget.onTap,
                keyboardType: widget.inputType ??
                    (widget.numberOnly
                        ? const TextInputType.numberWithOptions()
                        : null),
                readOnly: widget.readOnly,
                inputFormatters: formatter,
                textCapitalization: widget.setUpperCase
                    ? TextCapitalization.characters
                    : TextCapitalization.none,
                decoration: InputDecoration(
                  isCollapsed: true,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.only(left: 8, right: 8, top: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelText: widget.label.toString(),
                  hintText: widget.hint,
                  filled: true,
                  fillColor: widget.fillColor,
                  hintStyle: AppTheme.body1(),
                  labelStyle: AppTheme.subtitle1(color: AppTheme.blue50),
                  floatingLabelBehavior: widget.hint != null
                      ? FloatingLabelBehavior.always
                      : FloatingLabelBehavior.auto,
                  floatingLabelStyle:
                      AppTheme.subtitle1(color: AppTheme.blue50),
                  counterText: '',
                ),
                obscureText: widget.obscureText,
                maxLength: widget.maxLength,
                onChanged: widget.onChanged,
                maxLines: widget.maxLines,
              ),
            ),
            if (widget.trailing != null)
              Flexible(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 12),
                  child: InkWell(
                      onTap: widget.trailingTap ?? widget.onTap,
                      child: widget.trailing ?? Container()),
                ),
              )
          ],
        ),
      ),
    );
  }
}
