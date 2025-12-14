// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pixa_project/utils/constants.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton({
    super.key,
    required this.text,
    this.fontSize,
    this.borderColor,
    this.txtColor,
    required this.onTap,
    this.color,
    this.borderWidth,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.iconColor,
    this.iconSize,
    this.padding,
    this.width,
    this.textHeight,
    this.radius = appBorderRadius,
    this.border = false,
    this.enable = true,
  });
  final bool? border;
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? borderColor;
  final Color? iconColor;
  final Color? txtColor;
  final double? fontSize;
  final double? iconSize;
  final double? width;
  final double? radius;
  final EdgeInsets? padding;
  final double? borderWidth;
  final double? textHeight;
  final MainAxisAlignment mainAxisAlignment;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ButtonStyle(
      elevation: MaterialStateProperty.all<double?>(0.5),
      // shadowColor: MaterialStateProperty.all<Color>(
      //     context.buttonColor ?? AppColor.buttonColor),
      backgroundColor: MaterialStateProperty.all<Color?>(
        enable ? color : color?.withOpacity(0.5),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 45.0),
          side: border == true
              ? BorderSide(color: borderColor ?? Constants.appColor)
              : BorderSide.none,
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(
        padding ?? EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      ),
    );

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: enable ? onTap : null,
        style: style,
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Text(
              text,
              maxLines: 1,
              // strutStyle:
              //     const StrutStyle(forceStrutHeight: true, height: 1.2),
              style: TextStyle(
                height: textHeight,
                color: txtColor ?? Colors.white,
                fontSize: fontSize ?? 18,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
