
class LabelDetails {
  int buildingId = 0;
  int xCoordinate = 0;
  int yCoordinate = 0;
  int floor = 0;
  String labelName = 'sample';
  String iconName = 'sample';

  LabelDetails(buildingId,xCoordinate,yCoordinate,floor,labelName,iconName) {
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
