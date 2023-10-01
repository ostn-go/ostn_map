import 'package:flutter/material.dart';

abstract class Global {
  static const Color blue = const Color(0xFF78909C);
  static const Color backgroundBlack = const Color(0xFF78909C);
  static const Color wallBlack = const Color(0xFFB0BEC5);
  static const Color pathBlack = const Color(0xFF455A64);
  static const Color fontBlack = const Color(0xFF212121);
  static const Color orangeMapIcon = const Color(0xFFF57F17);
  static const Color redLocationIconColor = const Color(0xFFE53935);


  static const List lights = [
    {
      'location': 'Lobby',
      'name': 'Lobby',
      'status': false,
      'position': [0.0, 0.0],
      'tile': 1669,
    }
  ];

  static const Map<int, String> labelMap = {
    1669: 'Dining',
    1500: 'Something'
  };

}
