import 'package:flutter/material.dart';
import '../../core/viewmodels/map_labels.dart';
import '../../core/viewmodels/user_location.dart';
import '../../services/MapDataService.dart';
import 'floorplan_screen.dart';


class BuildingSearchDelegate extends SearchDelegate {

  List<BuildingDetails> labelDetails = BuildingDetailsResult().buildingDetails;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark(
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),

    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
      },
      icon: Icon(Icons.menu),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<BuildingDetails> matchQuery = [];
    for (var label in labelDetails) {
      if (label.buildingName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(label);
      }
    }
    return ListView.separated(
      itemCount: matchQuery.length,
      separatorBuilder: (context, index) => Divider(), // Add dividers
      itemBuilder: (context, index) {
        BuildingDetails result = matchQuery[index];
        return GestureDetector(
          onTap: () async {
            FloorMapUrl().imageUrl = "http://localhost:8082/ostn/image/" + result.buildingId.toString();
            FloorMapUrl().currentFloor = 0;
            List<dynamic> labelDetailsDynamic = await fetchLabels(result.buildingId.toString());
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

            List<dynamic> buildingMapDetails = await fetchBuildingMap(result.buildingId.toString());
            BuildingMapDetailsResult().buildingDetails = buildingMapDetails.map((dynamic item) {
              return BuildingMapDetails(
                  item["floorId"],
                  item["buildingId"],
                  item["map"],
                  item["axisCount"]
              );
            }).toList();

            List<dynamic> transportDetails = await fetchTransportDetails(result.buildingId.toString());

            TransportDetailsResult().transportDetails = transportDetails.map((dynamic item) {
              return TransportDetails(
                item["buildingId"],
                item["floorId"],
                item["xCoordinate"],
                item["yCoordinate"],
                item["mode"],
              );
            }).toList();

            close(context, null);
            Navigator.of(context).push(_customPageRoute('/map'));

          },
          child: ListTile(
            title: Row(
              children: [
                Icon(Icons.business_outlined),
                SizedBox(width: 10),
                Text(result.buildingName),
              ],
            ),
            subtitle: Text("         Street: " + result.street + "\n         " + result.description),

          ),
        );
      },
    );
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    List<BuildingDetails> matchQuery = [];
    for (var label in labelDetails) {
      if (label.buildingName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(label);
      }
    }
    return ListView.separated(
      itemCount: matchQuery.length,
      separatorBuilder: (context, index) => Divider(), // Add dividers
      itemBuilder: (context, index) {
        BuildingDetails result = matchQuery[index];
        return GestureDetector(
          onTap: () async {

            FloorMapUrl().imageUrl = "http://localhost:8082/ostn/image/" + result.buildingId.toString();
            FloorMapUrl().currentFloor = 0;
            List<dynamic> labelDetailsDynamic = await fetchLabels(result.buildingId.toString());
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

            List<dynamic> buildingMapDetails = await fetchBuildingMap(result.buildingId.toString());
            BuildingMapDetailsResult().buildingDetails = buildingMapDetails.map((dynamic item) {
              return BuildingMapDetails(
                  item["floorId"],
                  item["buildingId"],
                  item["map"],
                  item["axisCount"]
              );
            }).toList();

            List<dynamic> transportDetails = await fetchTransportDetails(result.buildingId.toString());

            TransportDetailsResult().transportDetails = transportDetails.map((dynamic item) {
              return TransportDetails(
                item["buildingId"],
                item["floorId"],
                item["xCoordinate"],
                item["yCoordinate"],
                item["mode"],
              );
            }).toList();

            Navigator.of(context).push(_customPageRoute('/map'));
          },
          child: ListTile(
            title: Row(
              children: [
                Icon(Icons.business_outlined ), // Replace with your desired icon
                SizedBox(width: 10), // Adjust the spacing as needed
                Text(result.buildingName),
              ],
            ),
            subtitle: Text("         Street: " + result.street + "\n         " + result.description),
          ),
        );
      },
    );
  }




}

PageRoute _customPageRoute(String routeName) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return FloorPlanScreenWidget(); // Replace with the widget for your target route
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    settings: RouteSettings(name: routeName),
  );
}
