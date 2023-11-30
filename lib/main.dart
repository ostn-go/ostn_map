import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/services/MapDataService.dart';
import 'package:custom_zoomable_floorplan/view/screens/login_page.dart';
import 'package:custom_zoomable_floorplan/view/screens/panorama_screen.dart';
import 'package:custom_zoomable_floorplan/view/widgets/main_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/viewmodels/map_labels.dart';
import 'core/viewmodels/user_location.dart';
import 'view/screens/floorplan_screen.dart';


void main() async {

  List<dynamic> buildingDetailsDynamic = await fetchBuildingDetails();
  BuildingDetailsResult().buildingDetails = buildingDetailsDynamic.map((dynamic item) {
    return BuildingDetails(
        item["buildingId"],
        item["buildingName"],
        item["lat"],
        item["lon"],
        item["description"],
        item["city"],
        item["street"],
        item["landmark"],
        item["pinCode"],
        item["country"],
        item["phoneNumber"]
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
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/login', // Define your initial route
        routes: {
          '/map': (context) => FloorPlanScreenWidget(), // Your existing page
          '/login': (context) => MainView(),
          '/panorama': (context) => PanoramaScreen(),// Add the login page as a route
        },
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
