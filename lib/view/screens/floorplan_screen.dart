import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:custom_zoomable_floorplan/view/widgets/direction_dots_widget.dart';
import 'package:custom_zoomable_floorplan/view/widgets/gridview_widget.dart';
import 'package:custom_zoomable_floorplan/view/widgets/raw_gesture_detector_widget.dart';
import 'package:custom_zoomable_floorplan/view/widgets/reset_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/models.dart';
import '../../core/viewmodels/map_labels.dart';
import '../../core/viewmodels/user_location.dart';
import '../widgets/raw_rotation_gesture.dart';
import '../widgets/search_button_widget.dart';
import 'CustomSearchDelegate.dart';

class FloorPlanScreenWidget extends StatefulWidget {
  @override
  State<FloorPlanScreenWidget> createState() => _FloorPlanScreen();

}

class _FloorPlanScreen extends State<FloorPlanScreenWidget> {
  @override
  Widget build(BuildContext context) {
    List<LabelDetails> labelDetails = LabelDetailsResult().labelDetails.where((label) => label.floorId == FloorMapUrl().currentFloor).toList();
    final model = Provider.of<FloorPlanModel>(context);
    return Scaffold(
      backgroundColor: Global.backgroundBlack,
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: RawGestureDetectorWidget(
                    child: GridViewWidget(),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: List.generate(
                    labelDetails.length,
                        (idx) {
                          Pos transformedAxis = Global.axisTransformation(Pos((MinMapTileSize().minMapTileSize*(labelDetails[idx].xCoordinate-25)),(MinMapTileSize().minMapTileSize*(labelDetails[idx].yCoordinate-25))), model.currAngle,model.pos);
                      return
                          Align(
                            alignment: Alignment.center,
                            child:Transform.translate(
                              offset: Offset(
                                (transformedAxis.x+model.pos.x)*model.scale,
                                (transformedAxis.y+model.pos.y)*model.scale,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  double minTile = MinMapTileSize().minMapTileSize;
                                  double labelX =   ((minTile*(labelDetails[idx].xCoordinate-25)) + (minTile/2));
                                  double labelY =  ((minTile*(labelDetails[idx].yCoordinate-25)) + (minTile/2));
                                  model.moveToLabelLocation(-1*labelX, -1*labelY);
                                  showLabelDetailsPopUp(labelDetails[idx],model);
                                  print(labelDetails[idx].labelName);
                                },
                                child: Stack(
                                  alignment: Alignment.center,

                                  children: <Widget>[
                                    CircleAvatar(

                                      backgroundColor: Colors.transparent,
                                      radius: 10.0 + model.scale, // Set the desired fixed radius
                                      child: IgnorePointer(
                                        child: Center(
                                          child: Icon(
                                            Icons.location_on,
                                            color: Global.redLocationIconColor,
                                            size: 15 + 2*model.scale,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Transform(
                                      transform: Matrix4.identity()..translate(0.0,15.0,0.0),
                                      child: Text(
                                        labelDetails[idx].labelName,
                                        style: TextStyle(
                                          fontSize: 7.0+ model.scale,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                    },
                  ),
                ),
                if(model.isDirectionDots)
                  Align(
                    alignment: Alignment.center,
                    child: RotationGestureDetectorWidget(
                      child: DirectionDotViewWidget(),
                    ),
                  ),
                if(model.isDirectionDots)
                Positioned(
                  bottom: 100, // Adjust the position as needed
                  right: 30, // Adjust the position as needed
                  child: GestureDetector(
                    onTap: () {
                      model.isDirectionDots=false;
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          "Exit",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ResetButtonWidget(),
                SearchButtonWidget(
                  onPressedCallback: () {
                    // Add your custom onPressed logic here
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(), // Your custom delegate
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showLabelDetailsPopUp(LabelDetails labelDetails, FloorPlanModel model) {

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: double.infinity,
        height: 400, // Increased height to accommodate the button
        color: Global.fontBlack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
              child: Text(
                labelDetails.labelName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
              child: Text(
                labelDetails.description,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
              child: Container(
                height: 200, // Set the height for the image row
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Scroll horizontally
                  itemCount: 6, // Number of images in the array
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.0), // Add spacing between images
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          "https://picsum.photos/250?image=" + index.toString(), // Use the image URL from the array
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Add a button to the popup
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0,right:230),
              child: ElevatedButton(
                onPressed: () {

                  // Handle button click here
                  print("Direction ON");
                  print(labelDetails);
                  model.isDirectionDots = true;
                  DirectionDotEnd().pos = DirectionDotPos(labelDetails.xCoordinate,labelDetails.yCoordinate);
                  Navigator.pop(context);


                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Change the button color
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.directions, // Add your desired icon
                      color: Colors.white, // Icon color
                    ),
                    SizedBox(width: 10), // Add spacing between icon and text
                    Text(
                      'Directions',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showNavigationPop() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: double.infinity,
        height: 100,
        color: Global.searchBarBlack,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You are on floor " + FloorMapUrl().currentFloor.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

/*
The build() method first gets the model from the context. Then, it creates a Scaffold widget with the following properties:

    The backgroundColor property is set to the backgroundColor property of the class.
    The appBar property is set to the appBar property of the class.
    The body property is set to a Stack widget with the following children:
        A RawGestureDetectorWidget widget with the GridViewWidget() widget as its child.
        A ResetButtonWidget() widget if the model.hasTouched property is true. Otherwise, a OverlayWidget() widget.


 */