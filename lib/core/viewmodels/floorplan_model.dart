import 'package:custom_zoomable_floorplan/core/models/models.dart';
import 'package:custom_zoomable_floorplan/core/viewmodels/user_location.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:flutter/cupertino.dart';

import '../../services/MapDataService.dart';

class Pos {
  double x = 0.0;
  double y = 0.0;

  Pos(x, y) {
    this.x = x;
    this.y = y;
  }
}

class FloorPlan {
  static FloorPlan? _instance;
  List floorPlan;

  factory FloorPlan() {
    _instance ??= FloorPlan._([]);
    return _instance!;
  }

  FloorPlan._(this.floorPlan);
}

class FloorPlanModel extends ChangeNotifier {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Pos _pos = Pos(0.0, 0.0);
  Pos _cus_pos = Pos(0.0, 0.0);
  Pos _previousPos = Pos(0.0, 0.0);
  Pos _endPos = Pos(0.0, 0.0);
  bool _isScaled = false;

  double get scale => _scale;
  double get previousScale => _previousScale;
  Pos get pos => _pos;
  Pos get previousPos => _previousPos;
  Pos get endPos => _endPos;
  bool get isScaled => _isScaled;

  bool _hasTouched = false;
  bool get hasTouched => _hasTouched;
  set hasTouched(value) {
    _hasTouched = value;
    notifyListeners();
  }

  Pos get cus_pos => _cus_pos;
  set cus_pos(value) {
    _cus_pos = value;
    notifyListeners();
  }

  List<Light> _lights = Global.lights.map((item) => Light.fromMap(item)).toList();
  List<Light> get lights => _lights;

  void handleDragScaleStart(ScaleStartDetails details) {
    _hasTouched = true;
    _previousScale = _scale;
    _previousPos.x = (details.focalPoint.dx / _scale) - _endPos.x;
    _previousPos.y = (details.focalPoint.dy / _scale) - _endPos.y;
    notifyListeners();
  }

  void handleDragScaleUpdate(ScaleUpdateDetails details) {
    _scale = _previousScale * details.scale;
    if (_scale > 2.0) {
      _isScaled = true;
    } else {
      _isScaled = false;
    }

    if (_scale < 1.0) {
      _scale = 1.0;
    } else if (_scale > 4.0) {
      _scale = 4.0;
    } else if (_previousScale == _scale) {
      _pos.x = (details.focalPoint.dx / _scale) - _previousPos.x;
      _pos.y = (details.focalPoint.dy / _scale) - _previousPos.y;
    }
    notifyListeners();
  }

  reset() async {
   // print(fetchData());
   // List<dynamic> dynamicList = await fetchData();
   // List<int> intList = dynamicList.map((item) => item as int).toList();
   // print(intList[0]);
    _scale = 3.0;
    _previousScale = 1.0;
    _pos = Pos(-1*UserLocation().pos.x, UserLocation().pos.y);
    _previousPos = Pos(0.0, 0.0);
    _endPos = Pos(0.0, 0.0);
    _isScaled = false;
    notifyListeners();
  }

  void handleDragScaleEnd() {
    _previousScale = 1.0;
    _endPos = _pos;
    notifyListeners();
  }
}