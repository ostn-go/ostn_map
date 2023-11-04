
class PosUser {
  double x = 0.0;
  double y = 0.0;

  PosUser(x, y) {
    this.x = x;
    this.y = y;
  }
}

class UserLocation {
  static UserLocation? _instance;
  PosUser pos;

  factory UserLocation() {
    _instance ??= UserLocation._(PosUser(0.0,0.0));
    return _instance!;
  }

  UserLocation._(this.pos);
}


class IsNavigationOn {
  static IsNavigationOn? _instance;
  bool isNavigationOn;

  factory IsNavigationOn() {
    _instance ??= IsNavigationOn._(false);
    return _instance!;
  }

  IsNavigationOn._(this.isNavigationOn);
}

class MinMapTileSize {
  static MinMapTileSize? _instance;
  double minMapTileSize;

  factory MinMapTileSize() {
    _instance ??= MinMapTileSize._(7.0);
    return _instance!;
  }

  MinMapTileSize._(this.minMapTileSize);
}


class FloorMapUrl {
  static FloorMapUrl? _instance;
  String imageUrl;
  int currentFloor;

  factory FloorMapUrl() {
    _instance ??= FloorMapUrl._("",0);
    return _instance!;
  }

  FloorMapUrl._(this.imageUrl,this.currentFloor);
}