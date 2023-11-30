import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/viewmodels/floorplan_model.dart';
import '../../main.dart';
import '../widgets/main_login_widget.dart';

abstract class Global {
  static const Color blue = const Color(0xFF78909C);
  static const Color backgroundBlack = const Color(0xFF78909C);
  static const Color wallBlack = const Color(0xFFB0BEC5);
  static const Color pathBlack = const Color(0xFF455A64);
  static const Color fontBlack = const Color(0xFF212121);
  static const Color redLocationIconColor = const Color(0xFFE53935);
  static const Color searchBarBlack = const Color(0xFF424242);


  static Pos axisTransformation(Pos pos, double angle,Pos axisChange) {

    double x = pos.x;
    double y = pos.y;
    double axisTX = x * cos(angle) - y * sin(angle);
    double axisTY = x * sin(angle) + y * cos(angle);

    double x1 = axisTX;
    double y1 =  axisTY;

    double axisCX =  x1 * cos(angle) - y1 * sin(angle);
    double axisCY =  x1 * sin(angle) + y1 * cos(angle);

    return Pos(axisTX,axisTY);
  }
}



