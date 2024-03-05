import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manage_app/app/manager/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final TextDirection? hintTextDirection;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? defaultText;
  final String? errorText;
  final String? fontFamily;
  final FocusNode? focusNode;
  final bool? isObscure;
  final bool? filled;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final Function? onFieldTap;
  final Function(String)? onChanged;
  final String? label;
  final String? richS1;
  final String? richS2;
  final bool? hasDecoration;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final bool? enabled;
  final bool? autoFocus;
  final Color? fillColor;
  final Color? filledColor;
  final Color? labelColor;
  final bool? hasFocus;
  final bool? isRequired;
  final String? obscureSymbol;
  final InputBorder? border;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final bool? wantListeners;
  final Function(bool)? onFocusChange;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool? showCursor;
  final bool? showCounter;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? textAlign;
  final TextCapitalization textCapitalization;
  final bool? autoCorrect;
  final bool? enableSuggestions;
  final TextStyle? style;
  final AutovalidateMode? autovalidateMode;

  const TextFormFieldWidget({
    this.controller,
    Key? key,
    this.hintText,
    this.filled,
    this.hintTextDirection,
    this.hintStyle,
    this.focusNode,
    this.textInputType,
    this.defaultText,
    this.fontFamily,
    this.errorText,
    this.isObscure = false,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.onSaved,
    this.onFieldSubmitted,
    this.onFieldTap,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.richS1 = '',
    this.richS2 = '',
    this.hasDecoration = true,
    this.minLines = 1,
    this.maxLines = 1,
    this.readOnly = false,
    this.enabled = true,
    this.autoFocus = false,
    this.fillColor,
    this.filledColor = Colors.white,
    this.labelColor,
    this.hasFocus = false,
    this.isRequired = false,
    this.showCursor,
    this.obscureSymbol,
    this.border,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.wantListeners = false,
    this.onFocusChange,
    this.inputFormatters,
    this.maxLength,
    this.showCounter,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 17.0, vertical: 16.0),
    this.textAlign,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.autoCorrect = true,
    this.enableSuggestions = true,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var roundedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColor.greyColor, width: 1),
      borderRadius: BorderRadius.circular(10),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          showCursor: showCursor,
          autovalidateMode: autovalidateMode,
          autocorrect: autoCorrect!,
          cursorColor: Theme.of(context).primaryColor,
          obscureText: isObscure!,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          focusNode: focusNode,
          readOnly: readOnly,
          enabled: enabled,
          autofocus: autoFocus!,
          enableSuggestions: enableSuggestions!,
          textCapitalization: textCapitalization,
          style: style,
          strutStyle: const StrutStyle(
            fontSize: 15.0,
            forceStrutHeight: true,
          ),
          initialValue: defaultText,
          onChanged: onChanged,
          minLines: minLines,
          maxLines: maxLines,
          keyboardAppearance: Theme.of(context).brightness,
          textAlign: textAlign ?? TextAlign.start,
          buildCounter: (context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
          decoration: InputDecoration(
            enabled: true,

            suffixIcon: suffixIcon,

            prefixIcon: prefixIcon,
            filled: filled,
            fillColor: fillColor,
            hintText: hintText,
            hintTextDirection: hintTextDirection,
            border: hasDecoration! ? border ?? roundedBorder : InputBorder.none,
            errorBorder: hasDecoration!
                ? errorBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColor.redColor, width: 1.5),
                    )
                : InputBorder.none,
            focusedBorder: hasDecoration!
                ? focusedBorder ??
                    OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColor.primaryColor, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    )
                : null,
            focusedErrorBorder: hasDecoration!
                ? focusedErrorBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColor.redColor, width: 1.5),
                    )
                : InputBorder.none,
            enabledBorder: hasDecoration!
                ? enabledBorder ??
                    OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primaryColor.withOpacity(.5), width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    )
                : InputBorder.none,
            disabledBorder: hasDecoration!
                ? disabledBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColor.primaryColor.withOpacity(.5), width: 1.5),
                    )
                : InputBorder.none,
            contentPadding: contentPadding,
            isDense: true,
            errorText: errorText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            errorMaxLines: 2,
          ),
          controller: controller,
          validator: validator,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          inputFormatters: inputFormatters,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          onTap: () {
            if (onFieldTap != null) onFieldTap?.call();
          },
        ),
      ],
    );
  }
}
