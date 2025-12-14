import 'dart:math';

import 'package:uuid/uuid.dart';

/// generate uid for party and sell order
String generateUId() => const Uuid().v4();

///for payment series
// String generateId() => DateTime.now().hashCode.toString();

int generateRandom() => Random().nextInt(100000);
