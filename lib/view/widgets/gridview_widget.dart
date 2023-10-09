import 'package:custom_zoomable_floorplan/core/models/models.dart';
import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/core/viewmodels/user_location.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
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
  String imageUrl = "http://localhost:8082/ostn/image/1001";
  late Future<List<dynamic>> dynamicList;
  // Coordinates
  final GlobalKey _key = GlobalKey();
  List<LabelDetails> labelDetails = LabelDetailsResult().labelDetails;
  // This function is called when the user presses the floating button
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
    final model = Provider.of<FloorPlanModel>(context, listen: false);
    // print(intList[0]);

    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      // Make an API call to fetch data
      fetchUserLocation(bleUserPosition).then((data) {
        setState(() {
          _getOffset(_key);
          MinMapTileSize().minMapTileSize=_x!;
          if(IsNavigationOn().isNavigationOn) {
            model.trackUser();
          }
          //iconX =    iconX + data['x']*_x;
          //iconY =  iconY + data['y']*_y;
          iconX =   ((_x!*(data['x']-25)) + (_x!/2));
          iconY =  ((_y!*(data['y']-25)) + (_y!/2));
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
          imageUrl,
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
        Stack(
          children: List.generate(
            labelDetails.length,
                (idx) {
              return Transform.translate(
                offset: Offset(
                  ((_x!*(labelDetails[idx].xCoordinate-25)) + (_x!/2)),
                  ((_x!*(labelDetails[idx].yCoordinate-25)) + (_x!/2)),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 14.0, // Set the desired fixed radius
                      child: IgnorePointer(
                        child: Center(
                          child: Icon(
                            labelDetails[idx].iconName != 'sample'
                                ? IconData(int.parse(labelDetails[idx].iconName, radix: 16), fontFamily: 'MaterialIcons')
                                : Icons.location_on,
                            color: Global.redLocationIconColor,
                            size: 14,
                          ),
                        ),
                      ),
                    ) ,
                    Transform(
                      transform: Matrix4.identity()..translate(0.0,10.0),
                      child: Text(
                        labelDetails[idx].labelName,
                        style: TextStyle(
                          fontSize: 6.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )

      ],
    );
  }
}