import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get appName => 'Pixa';
  static Color get appColor => Colors.green;
  static bool get isDark => false;
  static Duration get durationRequest => Duration(seconds: 120);
  static String get pixKey => dotenv.env['KEY'] ?? '';
  static String get baseUrl => 'https://pixabay.com/api/';
}

const double appBorderRadius = 15;
