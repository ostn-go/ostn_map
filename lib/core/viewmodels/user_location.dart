
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

class FloorPlanModel extends ChangeNotifier {
  Pos _current_user_pos = Pos(0.0, 0.0);

  Pos get current_user_pos => _current_user_pos;

  set current_user_pos(value) {
    _current_user_pos = value;
    notifyListeners();
  }

  void findTheCurrentLocation() {
    Pos curr = _current_user_pos;
    _current_user_pos = Pos(curr.x, curr.y);
  }

}