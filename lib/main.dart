import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/services/MapDataService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/viewmodels/map_labels.dart';
import 'core/viewmodels/user_location.dart';
import 'view/screens/floorplan_screen.dart';


void main() async {
  FloorMapUrl().imageUrl = "http://localhost:8082/ostn/image/1001/0";
  FloorMapUrl().currentFloor = 0;
  List<dynamic> labelDetailsDynamic = await fetchLabels();
  LabelDetailsResult().labelDetails = labelDetailsDynamic.map((dynamic item) {
    return LabelDetails(
      item["buildingId"],
      item["labelId"],
      item["floorId"],
      item["description"],
      item["xCoordinate"],
      item["yCoordinate"],
      item["floor"],
      item["labelName"],
      item["iconName"]
    );
  }).toList();

  List<dynamic> buildingMapDetails = await fetchBuildingMap();
  BuildingMapDetailsResult().buildingDetails = buildingMapDetails.map((dynamic item) {
     return BuildingMapDetails(
        item["floorId"],
        item["buildingId"],
         item["map"],
        item["axisCount"]
    );
  }).toList();

  print(BuildingMapDetailsResult().buildingDetails[0].map[0]);

  List<dynamic> transportDetails = await fetchTransportDetails();

  TransportDetailsResult().transportDetails = transportDetails.map((dynamic item) {
    return TransportDetails(
        item["buildingId"],
        item["floorId"],
        item["xCoordinate"],
        item["yCoordinate"],
       item["mode"],
    );
  }).toList();

  print(TransportDetailsResult().transportDetails[0].mode);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FloorPlanModel>(create: (context) => FloorPlanModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: FloorPlanScreenWidget(),
      ),
    );
  }
}

/*

The code ChangeNotifierProvider<FloorPlanModel>(create: (context) => FloorPlanModel())
 is a widget in Flutter that provides an instance of the FloorPlanModel class to its descendants.
 The FloorPlanModel class is a ChangeNotifier: https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html,
  which means that it can notify its listeners whenever its state changes.
  This allows the widgets that are listening to the FloorPlanModel to be updated whenever
   the data in the model changes.
 */
