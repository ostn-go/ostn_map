import '../viewmodels/floorplan_model.dart';

class Light {
  late String location;
  late String name;
  late bool status;
  late List<double> position;
  late int tile;

  Light.fromMap(Map data) {
    this.location = data['location'] ?? 'No location.';
    this.name = data['name'] ?? 'No name.';
    this.status = data['status'] ?? false;
    this.position = data['position'] ?? [0.0];
    this.tile = data['tile'] ?? 0;
  }

}

class BleUserPosition {
  late Pos coordinates;
  late double distance;


  BleUserPosition(coordinates,distance) {
    this.coordinates = coordinates;
    this.distance = distance;
  }
}

class DirectionDotRequest {
  int xStart = 0;
  int yStart = 0;
  int xEnd=0;
  int yEnd=0;
  List<dynamic> floorData=[];
  int crossAxisCount=0;


  DirectionDotRequest(xStart,yStart,xEnd,yEnd,floorData,crossAxisCount) {
    this.xStart = xStart;
    this.yStart = yStart;
    this.xEnd = xEnd;
    this.yEnd = yEnd;
    this.floorData = floorData;
    this.crossAxisCount = crossAxisCount;
  }
  Map<String, dynamic> toJson() {
    return {
      'xStart': xStart,
      'yStart': yStart,
      'xEnd': xEnd,
      'yEnd': yEnd,
      'floorData': floorData,
      'crossAxisCount': crossAxisCount,
    };
  }
}

class DirectionDotPos {
  int x = 0;
  int y = 0;

  DirectionDotPos(x, y) {
    this.x = x;
    this.y = y;
  }
}

class DirectionDotStart {
  static DirectionDotStart? _instance;
  DirectionDotPos pos;

  factory DirectionDotStart() {
    _instance ??= DirectionDotStart._(DirectionDotPos(0,0));
    return _instance!;
  }

  DirectionDotStart._(this.pos);
}

class DirectionDotEnd {
  static DirectionDotEnd? _instance;
  DirectionDotPos pos;

  factory DirectionDotEnd() {
    _instance ??= DirectionDotEnd._(DirectionDotPos(0,0));
    return _instance!;
  }

  DirectionDotEnd._(this.pos);
}

