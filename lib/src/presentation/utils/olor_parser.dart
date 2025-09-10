import 'package:flutter/material.dart';

Color parseHex(String hex, {Color fallback = const Color(0xff0ea5e9)}) {
  final v = hex.replaceAll('#', '');
  if (v.length != 6) return fallback;
  return Color(int.parse('0xff$v'));
}
