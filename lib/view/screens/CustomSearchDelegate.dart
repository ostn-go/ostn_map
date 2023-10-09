import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/floorplan_model.dart';
import '../../core/viewmodels/map_labels.dart';
import '../../core/viewmodels/user_location.dart';
import '../shared/global.dart';

class CustomSearchDelegate extends SearchDelegate {
// Demo list to show querying
  List<String> labelDetailNames = LabelDetailsResult().labelDetails.map((labelDetail) => labelDetail.labelName).toList();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark(
    );
  }

// first overwrite to
// clear the search text
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
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in labelDetailNames) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.separated(
      itemCount: matchQuery.length,
      separatorBuilder: (context, index) => Divider(), // Add dividers
        itemBuilder: (context, index) {
          final model = Provider.of<FloorPlanModel>(context, listen: false);
          var result = matchQuery[index];
          return GestureDetector(
            onTap: () {
              close(context, null);
              LabelDetails? foundLabelDetails = LabelDetailsResult().labelDetails.firstWhere(
                    (labelDetails) => labelDetails.labelName == "$result",
                orElse: () => LabelDetailsResult().labelDetails[0], // Return null if no match is found
              );
              double minTile = MinMapTileSize().minMapTileSize;
              double labelX =   ((minTile!*(foundLabelDetails.xCoordinate-25)) + (minTile!/2));
              double labelY =  ((minTile!*(foundLabelDetails.yCoordinate-25)) + (minTile!/2));
              model.moveToLabelLocation(-1*labelX, -1*labelY);
            },
            child: ListTile(
              title: Text(result),
            ),
          );
        },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in labelDetailNames) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.separated(
      itemCount: matchQuery.length,
      separatorBuilder: (context, index) => Divider(), // Add dividers
        itemBuilder: (context, index) {
          final model = Provider.of<FloorPlanModel>(context, listen: false);
          var result = matchQuery[index];
          return GestureDetector(
            onTap: () {
              close(context, null);
              LabelDetails? foundLabelDetails = LabelDetailsResult().labelDetails.firstWhere(
                    (labelDetails) => labelDetails.labelName == "$result",
                orElse: () => LabelDetailsResult().labelDetails[0], // Return null if no match is found
              );
              double minTile = MinMapTileSize().minMapTileSize;
              double labelX =   ((minTile!*(foundLabelDetails.xCoordinate-25)) + (minTile!/2));
              double labelY =  ((minTile!*(foundLabelDetails.yCoordinate-25)) + (minTile!/2));
              model.moveToLabelLocation(-1*labelX, -1*labelY);
            },
            child: ListTile(
              title: Text(result),
            ),
          );
        },
    );
  }
}
