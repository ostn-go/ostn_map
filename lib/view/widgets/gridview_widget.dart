import 'package:custom_zoomable_floorplan/core/models/models.dart';
import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/core/viewmodels/user_location.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';

import '../../services/MapDataService.dart';

class GridViewWidget extends StatefulWidget {
  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}


class _GridViewWidgetState extends State<GridViewWidget> {
  double iconX = 0.0;
  double iconY = 0.0;
  double iconSpeed = 0.5;
  late Future<List<dynamic>> dynamicList;
  // This key will be associated with the amber box
  final GlobalKey _key = GlobalKey();

  // Coordinates
  double? _x=0.0, _y=0.0;

  // This function is called when the user presses the floating button
  void _getOffset(GlobalKey key) {

    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    _x = size.width;
    _y = size.height;


  }

  @override
  void initState() {
    super.initState();
    dynamicList = fetchData();
    // print(intList[0]);

    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        if(iconX > 100){
          iconX =0.0;
        }
        else {
          _getOffset(_key);
          iconX += iconSpeed;

        }
        UserLocation().pos.x = iconX;
        UserLocation().pos.y = iconY;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final arrayM = FloorPlan().floorPlan;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //crossAxisSpacing: 2.0,
            //mainAxisSpacing: 2.0,
            crossAxisCount: 50,
            childAspectRatio: 1.0,
          ),
          itemCount: 2500,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            int currentTile = index + 1;
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  key: currentTile ==1 ? _key :null,
                  height: 10,
                  width: 10,
                  color: currentTile ==25 ? Colors.red : arrayM[currentTile-1] == 0 ? Global.backgroundBlack : arrayM[currentTile-1] == 1 ? Global.wallBlack: Global.pathBlack
                ),
                // Icon positioned on top of the main widget
              ],
            );
          },
        ),
        Transform.translate(
          offset: Offset(
            iconX,
            iconY,
          ),
          child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(80 / 255.0),
              ),
              child: Icon(
                Icons.adjust,
                size: 10,
                opticalSize: 3.0,
                color: Colors.lightBlue,
              )
          ),
        ),
      ],
    );
  }
}