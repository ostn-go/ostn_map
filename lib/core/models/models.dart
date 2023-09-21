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