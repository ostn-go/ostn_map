
import 'package:custom_zoomable_floorplan/core/models/models.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:flutter/cupertino.dart';

class Pos {
  double x = 0.0;
  double y = 0.0;

  Pos(x, y) {
    this.x = x;
    this.y = y;
  }
}

class UserLocation {
  static UserLocation? _instance;
  Pos pos;

  factory UserLocation() {
    _instance ??= UserLocation._(Pos(0.0,0.0));
    return _instance!;
  }

  UserLocation._(this.pos);
}