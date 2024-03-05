import 'package:flutter/material.dart';
import 'package:task_manage_app/app/manager/colors.dart';
import 'package:task_manage_app/app/utils/globals.dart';

class FilledButtons extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String text;
  final Color textColor;
  final Color color;

  /// By default it will take border radius of 30
  /// which means its rounded button by default
  final double? borderRadius;
  final double? width;
  final double? height;
  final double? elevation;
  final Color? borderSideColor;
  final Widget? leading;
  final Widget? trailing;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final double? borderWidth;
  final bool? isDisabled;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final InteractiveInkFeatureFactory? splashFactory;
  final bool applyGradient;
  final bool useExpanded;

  const FilledButtons({
    Key? key,
    required this.onTap,
    required this.text,
    this.textColor = Colors.white,
    this.color = AppColor.primaryColor,
    this.borderRadius = 10.0,
    this.width,
    this.height = 50,
    this.elevation,
    this.borderSideColor,
    this.leading,
    this.trailing,
    this.fontWeight = FontWeight.bold,
    this.fontFamily,
    this.fontSize = 17.0,
    this.isDisabled = false,
    this.padding,
    this.margin,
    this.borderWidth = 0.0,
    this.splashFactory,
    this.applyGradient = true,
    this.useExpanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize!,
        letterSpacing: 1,
        fontFamily: fontFamily,
        fontWeight: fontWeight!,
      ),
      textAlign: TextAlign.center,
    );

    return FilledButton(
      onPressed: onTap,
      autofocus: false,
      style: FilledButton.styleFrom(
        backgroundColor: color,
        shadowColor: Colors.transparent,
        padding: padding,
        elevation: elevation,
        alignment: Alignment.center,
        splashFactory: splashFactory,
        fixedSize: Size(width ?? screenWidth, height!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          side: BorderSide(color: borderSideColor ?? AppColor.primaryColor, width: borderWidth!),
        ),
      ),
      child: SizedBox(
        width: width ?? screenWidth,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading ?? const SizedBox(),
            if (useExpanded) Expanded(child: textWidget) else textWidget,
            trailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
