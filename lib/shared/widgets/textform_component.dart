import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rhea_app/shared/widgets/shadow_input_border.dart';
import 'package:rhea_app/styles/color.dart';

class TextFormComponent extends StatelessWidget {
  const TextFormComponent({
    super.key,
    this.inputFormatters,
    this.contentPadding,
    this.height,
    this.width,
    this.maxLines = 1,
    this.hasTitle = true,
    this.expands = false,
    this.shadowColor,
    this.radius = 10.0,
    this.shadowElevation = 4.0,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onSubmit,
    this.titleStyle,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction = TextInputAction.done,
    required this.controller,
    this.title,
    this.label,
    this.labelColor,
    this.focusColor,
    this.enableColor,
    this.titleColor,
    this.titlePadding,
    this.inputStyle,
  });
  final String? title;
  final String? label;
  final Color? labelColor;
  final Color? focusColor;
  final Color? enableColor;
  final Color? titleColor;
  final Color? shadowColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? titlePadding;
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final double? width;
  final int? maxLines;
  final bool expands;
  final bool obscureText;
  final bool hasTitle;
  final double radius;
  final double? shadowElevation;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final TextStyle? titleStyle;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? inputStyle;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasTitle)
          Padding(
            padding: titlePadding ?? EdgeInsets.zero,
            child: Text(
              title!,
              style: titleStyle,
            ),
          )
        else
          const SizedBox.shrink(),
        if (hasTitle) const SizedBox(height: 7) else const SizedBox.shrink(),
        SizedBox(
          width: width,
          height: height,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            maxLines: maxLines,
            onFieldSubmitted: onSubmit,
            expands: expands,
            cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
            enableInteractiveSelection: true,
            style: inputStyle,
            decoration: InputDecoration(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              labelText: label,
              labelStyle: Theme.of(context).textTheme.labelMedium,
              floatingLabelBehavior: floatingLabelBehavior,
              errorStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
              focusedBorder: ShadowInputBorder(
                elevation: shadowElevation ?? 4.0,
                fillColor: white,
                shadowColor: shadowColor ?? Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              enabledBorder: ShadowInputBorder(
                elevation: shadowElevation ?? 4.0,
                fillColor: white,
                shadowColor: shadowColor ?? Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              focusedErrorBorder: ShadowInputBorder(
                elevation: shadowElevation ?? 4.0,
                fillColor: white,
                shadowColor: shadowColor ?? Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              errorBorder: ShadowInputBorder(
                elevation: shadowElevation ?? 4.0,
                fillColor: white,
                shadowColor: shadowColor ?? Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              filled: true,
              isDense: true,
              contentPadding: contentPadding,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
