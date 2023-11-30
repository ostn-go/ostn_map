
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

class MailAddress {
  static MailAddress? _instance;
  String email;

  factory MailAddress() {
    _instance ??= MailAddress._("");
    return _instance!;
  }

  MailAddress._(this.email);
}

class Password {
  static Password? _instance;
  String password;

  factory Password() {
    _instance ??= Password._("");
    return _instance!;
  }

  Password._(this.password);
}

//Panorama URL
class PanoramaUrl {
  static PanoramaUrl? _instance;
  String imageUrl;

  factory PanoramaUrl() {
    _instance ??= PanoramaUrl._("");
    return _instance!;
  }

  PanoramaUrl._(this.imageUrl);
}

class DotPos {
  int x = 0;
  int y = 0;

  DotPos(x, y) {
    this.x = x;
    this.y = y;
  }
}


class DirectionDotResult {
  static DirectionDotResult? _instance;
  List<DotPos> directionDots;

  factory DirectionDotResult() {
    _instance ??= DirectionDotResult._([]);
    return _instance!;
  }

  DirectionDotResult._(this.directionDots);
}