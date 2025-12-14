import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  TextStyle get titleStyle {
    return (Theme.of(this).textTheme.bodyLarge ??
            const TextStyle(color: Colors.black))
        .copyWith(fontSize: 18);
  }
}
