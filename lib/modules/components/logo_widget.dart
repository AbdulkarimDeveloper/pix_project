import 'package:flutter/material.dart';
import 'package:pixa_project/utils/resources_path.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Image.asset(ResourcesPath.logo, fit: BoxFit.contain),
    );
  }
}
