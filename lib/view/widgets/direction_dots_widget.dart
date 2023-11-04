import 'dart:math';

import 'package:custom_zoomable_floorplan/core/models/models.dart';
import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/core/viewmodels/user_location.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../core/viewmodels/map_labels.dart';
import '../../services/MapDataService.dart';

class DirectionDotViewWidget extends StatefulWidget {
  @override
  State<DirectionDotViewWidget> createState() => _DirectionDotViewWidgetState();

}

class _DirectionDotViewWidgetState extends State<DirectionDotViewWidget> {

  List<dynamic> dotPosition=[];


  @override
  void initState() {
    if (mounted){
      super.initState();

    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      DirectionDotRequest directionDotRequest = DirectionDotRequest(
          DirectionDotStart().pos.x,
          DirectionDotStart().pos.y,
          DirectionDotEnd().pos.x,
          DirectionDotEnd().pos.y,
          BuildingMapDetailsResult().buildingDetails[0].map, 50
      );
      fetchDirectionDots(directionDotRequest).then((data) {
        if(mounted) {
          setState(() {
            dotPosition = data;
          });
        }
      });
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FloorPlanModel>(context);
    return Stack(
      alignment: Alignment.center,

      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: List.generate(
            dotPosition.length,
                (idx) {
                  Pos transformedAxis = Global.axisTransformation(Pos((MinMapTileSize().minMapTileSize*(dotPosition[idx]['x']-25)+MinMapTileSize().minMapTileSize/2),(MinMapTileSize().minMapTileSize*(dotPosition[idx]['y']-25)+MinMapTileSize().minMapTileSize/2)), model.currAngle,model.pos);
                  return Transform.translate(
                  offset: Offset(
                    transformedAxis.x,
                    transformedAxis.y,
                  ),

                  child:
                  Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.adjust,
                        size: 5,
                        opticalSize: 3.0,
                        color: Colors.lightBlue,
                      )
                  )
              );
            },
          ),
        )
      ],
    );
  }
}