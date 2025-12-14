import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixa_project/utils/constants.dart';
import 'package:pixa_project/utils/context_ext.dart';

class GeneralTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validate;
  final String? Function(String?)? onError;
  final Widget? prefixIcon;
  final Widget? subfixIcon;
  final String? hintText;
  final AutovalidateMode autovalidateMode;
  final int? maxLines;
  final Color? borderColor;
  final TextStyle? style;
  final bool readOnly;
  final List<TextInputFormatter> inputFormatters;
  final bool showLabel;
  final bool obscureText;
  final bool? isDense;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final double? borderRadius;
  final bool enable;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;
  final Function(String)? onChange;
  final FocusNode? focusNode;
  final void Function(String?)? onSubmit;
  final bool? isFilled;
  final Color? fillColor;
  final TextDirection? textDirection;
  final List<String>? autoFillList;

  const GeneralTextFiled({
    Key? key,
    required this.controller,
    this.inputFormatters = const [],
    this.showLabel = true,
    this.isDense,
    this.enable = true,
    this.keyboardType = TextInputType.text,
    this.onChange,
    this.onError,
    this.style,
    this.borderColor,
    this.borderRadius = appBorderRadius,
    this.textDirection,
    this.onSubmit,
    this.contentPadding,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.focusNode,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onTap,
    this.maxLines = 1,
    this.validate,
    this.subfixIcon,
    this.prefixIcon,
    this.autoFillList,
    this.textInputAction,
    this.isFilled,
    this.fillColor,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            textDirection: textDirection ?? TextDirection.ltr,
            textAlign: TextAlign.left,
            // textAlign: ThemeLangNotifier.instance.isEn
            //     ? TextAlign.left
            //     : TextAlign.right,
            textInputAction: textInputAction,
            autofocus: autofocus,
            controller: controller,
            autofillHints: autoFillList,
            onChanged: onChange,
            focusNode: focusNode,
            enabled: enable,
            onSaved: onSubmit,
            onFieldSubmitted: onSubmit,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            maxLines: maxLines,
            strutStyle: const StrutStyle(forceStrutHeight: true),
            style:
                style ??
                TextStyle(color: context.titleStyle.color, fontSize: 20),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              onError?.call(validate!(value));

              return validate?.call(value);
            },
            readOnly: readOnly,
            obscureText: obscureText,
            onTap: onTap,
            decoration: InputDecoration(
              errorMaxLines: 3,
              isDense: isDense,
              alignLabelWithHint: true,
              filled: isFilled,
              suffixIcon: subfixIcon,
              prefixIcon: prefixIcon,
              contentPadding:
                  contentPadding ?? const EdgeInsets.fromLTRB(15, 15, 15, 15),
              fillColor:
                  fillColor ?? Theme.of(context).inputDecorationTheme.fillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
                borderSide: BorderSide(
                  color: borderColor ?? Constants.appColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
                borderSide: BorderSide(
                  color: borderColor ?? Constants.appColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
                borderSide: const BorderSide(color: Color(0XFFFB6340)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
                borderSide: const BorderSide(color: Color(0XFFFB6340)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
                borderSide: BorderSide(
                  color: borderColor ?? Constants.appColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? Constants.appColor,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
              labelText: showLabel == true ? hintText ?? "" : null,
              labelStyle: TextStyle(
                fontSize: style?.fontSize ?? 17,
                color: Constants.appColor,
              ),
              errorStyle: const TextStyle(color: Color(0XFFFB6340)),
              hintText: showLabel == false ? hintText ?? "" : null,
              hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: style?.fontSize ?? 17,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomMagnifier extends StatelessWidget {
  const CustomMagnifier({super.key, required this.magnifierInfo});

  static const Size magnifierSize = Size(200, 200);

  // This magnifier will consume some text data and position itself
  // based on the info in the magnifier.
  final ValueNotifier<MagnifierInfo> magnifierInfo;

  @override
  Widget build(BuildContext context) {
    // Use a value listenable builder because we want to rebuild
    // every time the text selection info changes.
    // `CustomMagnifier` could also be a `StatefulWidget` and call `setState`
    // when `magnifierInfo` updates. This would be useful for more complex
    // positioning cases.
    return ValueListenableBuilder<MagnifierInfo>(
      valueListenable: magnifierInfo,
      builder: (BuildContext context, MagnifierInfo currentMagnifierInfo, _) {
        // We want to position the magnifier at the global position of the gesture.
        Offset magnifierPosition = currentMagnifierInfo.globalGesturePosition;

        // You may use the `MagnifierInfo` however you'd like:
        // In this case, we make sure the magnifier never goes out of the current line bounds.
        magnifierPosition = Offset(
          clampDouble(
            magnifierPosition.dx,
            currentMagnifierInfo.currentLineBoundaries.left,
            currentMagnifierInfo.currentLineBoundaries.right,
          ),
          clampDouble(
            magnifierPosition.dy,
            currentMagnifierInfo.currentLineBoundaries.top,
            currentMagnifierInfo.currentLineBoundaries.bottom,
          ),
        );

        // Finally, align the magnifier to the bottom center. The inital anchor is
        // the top left, so subtract bottom center alignment.
        magnifierPosition -= Alignment.bottomCenter.alongSize(magnifierSize);

        return Positioned(
          left: magnifierPosition.dx,
          top: magnifierPosition.dy,
          child: RawMagnifier(
            magnificationScale: 2,
            // The focal point starts at the center of the magnifier.
            // We probably want to point below the magnifier, so
            // offset the focal point by half the magnifier height.
            focalPointOffset: Offset(0, magnifierSize.height / 2),
            // Decorate it however we'd like!
            decoration: const MagnifierDecoration(
              shape: StarBorder(
                side: BorderSide(color: Colors.green, width: 2),
              ),
            ),
            size: magnifierSize,
          ),
        );
      },
    );
  }
}
