import 'package:custom_zoomable_floorplan/core/models/models.dart';
import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/core/viewmodels/user_location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../core/viewmodels/map_labels.dart';
import '../../services/MapDataService.dart';

class GridViewWidget extends StatefulWidget {
  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();

}
class _GridViewWidgetState extends State<GridViewWidget> {
  double iconX = 0.0;
  double iconY = 0.0;
  double iconSpeed = 0.5;
  bool isNavigationOn = true;
  FloorPlanModel floorPlanModel = FloorPlanModel();
  int xCoordinate = 0;
  int yCoordinate = 0;
  int buildingId = 0;
  int floorId = 0;
  int axisCount = 0;
  late Future<List<dynamic>> dynamicList;
  final GlobalKey _key = GlobalKey();
  List<LabelDetails> labelDetails = LabelDetailsResult().labelDetails;

  void _getOffset(GlobalKey key) {
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    _x = size.width/50;
    _y = size.height/50;
  }
  double? _x=5.0, _y=5.0;
  @override
  void initState() {
    super.initState();
    List<BleUserPosition> bleUserPosition = [];
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      fetchUserLocation(bleUserPosition).then((data) {
        setState(() {
          _getOffset(_key);
      //    DirectionDotStart().pos = DirectionDotPos(data['x'].toInt(),data['y'].toInt());
          DirectionDotStart().pos = DirectionDotPos(5,5);
          MinMapTileSize().minMapTileSize=_x!;
          iconX =   ((_x!*(5-25)) + (_x!/2));
          iconY =  ((_y!*(5-25)) + (_y!/2));
          // iconX =   ((_x!*(data['x']-25)) + (_x!/2));
          // iconY =  ((_y!*(data['y']-25)) + (_y!/2));
          UserLocation().pos.x = iconX;
          UserLocation().pos.y = iconY;

        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.network(
          key: _key,
          FloorMapUrl().imageUrl +"/" +FloorMapUrl().currentFloor.toString(),
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child; // If there's no progress, return the image.
            } else {
              // Show a loading indicator while the image is being loaded.
              return CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              );
            }
          },
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            // Handle errors, for example, by displaying an error icon.
            return Icon(Icons.error);
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