import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/services/MapDataService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/viewmodels/map_labels.dart';
import 'view/screens/floorplan_screen.dart';


void main() async {
  List<dynamic> labelDetailsDynamic = await fetchLabels();
  LabelDetailsResult().labelDetails = labelDetailsDynamic.map((dynamic item) {
    return LabelDetails(
      item["buildingId"],
      item["xCoordinate"],
      item["yCoordinate"],
      item["floor"],
      item["labelName"],
      item["iconName"],
    );
  }).toList();

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
        debugShowCheckedModeBanner: false,
        home: FloorPlanScreen(),
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
