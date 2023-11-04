import 'dart:async';
import 'dart:math';

import 'package:custom_zoomable_floorplan/core/models/models.dart';
import 'package:custom_zoomable_floorplan/core/viewmodels/user_location.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

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
  double _previousAngle = 0.0;
  double _angle = 0.0;
  double _previousScale = 1.0;
  Pos _pos = Pos(0.0, 0.0);
  Pos _cusPos = Pos(0.0, 0.0);
  Pos _previousPos = Pos(0.0, 0.0);
  Pos _endPos = Pos(0.0, 0.0);
  bool _isScaled = false;
  bool _isDirectionDots = false;

  bool get isDirectionDots => _isDirectionDots;

  set isDirectionDots(value) {
    _isDirectionDots = value;
    notifyListeners();
  }

  double get previousAngle => _previousAngle;
  double get currAngle => _angle;
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

  set currAngle(value) {
    _angle = value;
    notifyListeners();
  }
  Pos get cusPos => _cusPos;
  set cusPos(value) {
    _cusPos = value;
    notifyListeners();
  }


  void handleDragScaleStart(ScaleStartDetails details) {
    _previousScale = _scale;
    _previousPos.x = (details.focalPoint.dx / _scale) - _endPos.x;
    _previousPos.y = (details.focalPoint.dy / _scale) - _endPos.y;
    notifyListeners();
    if(details.pointerCount >= 2) {
      _previousAngle = _angle;
    }
  }


  void handleDragScaleUpdate(ScaleUpdateDetails details) {
    if(details.pointerCount >= 2) {
      _angle = details.rotation-_previousAngle;
    }
    _previousAngle = _angle;
    _scale = _previousScale * details.scale;
    if (_scale > 2.0) {
      _isScaled = true;
    } else {
      _isScaled = false;
    }

    if (_scale < 1.0) {
      _scale = 1.0;
    } else if (_scale > 10.0) {
      _scale = 10.0;
    } else if (_previousScale == _scale) {
      _pos.x = (details.focalPoint.dx / _scale) - _previousPos.x;
      _pos.y = (details.focalPoint.dy / _scale) - _previousPos.y;

    }
    notifyListeners();
  }

  reset()  {
    bool check = IsNavigationOn().isNavigationOn;
    IsNavigationOn().isNavigationOn = !check;
    _scale = 3.0;
    //_angle=0.0;
    _previousAngle=0.0;
    _previousScale = 1.0;
    double x = -1*UserLocation().pos.x;
    double y = -1*UserLocation().pos.y;
    _pos = Global.axisTransformation(Pos(x,y), _angle,_pos);
    _previousPos = Pos(0.0, 0.0);
    _endPos = Pos(0.0, 0.0);
    _isScaled = false;
    notifyListeners();
  }


  moveToLabelLocation(double x,double y)  {
    _scale = 3.0;
    _previousScale = 1.0;
    _pos = Global.axisTransformation(Pos(x,y), _angle,_pos);

    _previousPos = Pos(0.0, 0.0);
    _endPos = Pos(0.0, 0.0);
    _isScaled = false;
    notifyListeners();
  }

  void handleDragScaleEnd() {
    _previousAngle = _angle;
    _previousScale = 1.0;
    _endPos = _pos;
    notifyListeners();
  }
}