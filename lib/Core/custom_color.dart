// lib/core/constants/colors.dart
import 'package:flutter/material.dart';

class CustomColor {
  static const color1 = Color(0xFF3c507d);
  static const color2 = Color(0xFF112250);
  static const color3 = Color(0xFFe0c58f);
  static const color4 = Color(0xFFf5f0e9);
  static const white = Color(0xFFd9cbc2);
  static const white1 = Color(0xFFF6F6F6);
}

class AppGradient {
  static const LinearGradient sunset = LinearGradient(
    colors: [CustomColor.color1, CustomColor.color2,CustomColor.color3,CustomColor.color4],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );


}