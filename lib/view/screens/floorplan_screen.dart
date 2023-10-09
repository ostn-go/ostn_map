import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:custom_zoomable_floorplan/view/widgets/appbar_widget.dart';
import 'package:custom_zoomable_floorplan/view/widgets/gridview_widget.dart';
import 'package:custom_zoomable_floorplan/view/widgets/overlay_widget.dart';
import 'package:custom_zoomable_floorplan/view/widgets/raw_gesture_detector_widget.dart';
import 'package:custom_zoomable_floorplan/view/widgets/reset_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/search_button_widget.dart';
import 'CustomSearchDelegate.dart';

class FloorPlanScreenWidget extends StatefulWidget {
  @override
  State<FloorPlanScreenWidget> createState() => _FloorPlanScreen();

}

class _FloorPlanScreen extends State<FloorPlanScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FloorPlanModel>(context);

    return Scaffold(
      backgroundColor: Global.backgroundBlack,
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          color: Global.backgroundBlack,
          child: Center(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: RawGestureDetectorWidget(
                    child: GridViewWidget(),
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
                )
              ],
            ),
          ),
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