
class LabelDetails {
  int buildingId = 0;
  int labelId = 0;
  int floorId = 0;
  String description = "Sample";
  int xCoordinate = 0;
  int yCoordinate = 0;
  int floor = 0;
  String labelName = 'sample';
  String iconName = 'sample';

  LabelDetails(buildingId,labelId,floorId,description,xCoordinate,yCoordinate,floor,labelName,iconName) {
    this.labelId = labelId;
    this.floorId = floorId;
    this.description = description;
    this.buildingId = buildingId;
    this.xCoordinate = xCoordinate;
    this.yCoordinate = yCoordinate;
    this.floor = floor;
    this.labelName = labelName;
    this.iconName = iconName;
  }
}
class LabelDetailsResult {
  static LabelDetailsResult? _instance;
  List<LabelDetails> labelDetails;

  factory LabelDetailsResult() {
    _instance ??= LabelDetailsResult._([]);
    return _instance!;
  }

  LabelDetailsResult._(this.labelDetails);
}

class BuildingMapDetails {
  int buildingId = 0;
  int floorId = 0;
  List<dynamic> map = [];
  int axisCount=0;


  BuildingMapDetails(floorId,buildingId,map,axisCount) {
    this.floorId = floorId;
    this.buildingId = buildingId;
    this.map = map;
    this.axisCount = axisCount;
  }
}

class BuildingMapDetailsResult {
  static BuildingMapDetailsResult? _instance;
  List<BuildingMapDetails> buildingDetails;

  factory BuildingMapDetailsResult() {
    _instance ??= BuildingMapDetailsResult._([]);
    return _instance!;
  }

  BuildingMapDetailsResult._(this.buildingDetails);
}


class TransportDetails {
  int buildingId = 0;
  int floorId = 0;
  int xCoordinate=0;
  int yCoordinate=0;
  String mode="";


  TransportDetails(buildingId,floorId,xCoordinate,yCoordinate,mode) {
    this.buildingId = buildingId;
    this.floorId = floorId;
    this.xCoordinate = xCoordinate;
    this.yCoordinate = yCoordinate;
    this.mode = mode;
  }
}

class TransportDetailsResult {
  static TransportDetailsResult? _instance;
  List<TransportDetails> transportDetails;

  factory TransportDetailsResult() {
    _instance ??= TransportDetailsResult._([]);
    return _instance!;
  }

  TransportDetailsResult._(this.transportDetails);
}

