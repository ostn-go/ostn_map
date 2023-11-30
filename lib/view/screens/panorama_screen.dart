import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

import '../../core/viewmodels/map_labels.dart';
import '../../core/viewmodels/user_location.dart';
import 'floorplan_screen.dart';

class PanoramaScreen extends StatefulWidget {
  @override
  _PanoramaScreenState createState() => _PanoramaScreenState();
}

class _PanoramaScreenState extends State<PanoramaScreen> {
  double rotationX = -1.0;
  double rotationY = 0.0;
  double rotationZ = 1.57;
  int currIndex =0;
  int xCoordinate = 0;
  int yCoordinate = 0;
  int buildingId = 0;
  int floorId = 0;
  int axisCount = 0;


  @override
  void initState() {
    currIndex=0;
    xCoordinate = DirectionDotResult().directionDots.elementAt(currIndex).x;
    yCoordinate = DirectionDotResult().directionDots.elementAt(currIndex).y;
    floorId = FloorMapUrl().currentFloor;
    buildingId = BuildingMapDetailsResult().buildingDetails.elementAt(0).buildingId;
    axisCount = BuildingMapDetailsResult().buildingDetails.elementAt(0).axisCount;
    PanoramaUrl().imageUrl = "http://127.0.0.1:8083/image/$buildingId/$floorId/$axisCount/$xCoordinate/$yCoordinate";
    super.initState();
  }

  void _nextImage() {
    setState(() {
      currIndex=currIndex-3;
      if(currIndex < 0){
        currIndex=0;
      }
      xCoordinate = DirectionDotResult().directionDots.elementAt(currIndex).x;
      yCoordinate = DirectionDotResult().directionDots.elementAt(currIndex).y;
      floorId = FloorMapUrl().currentFloor;
      buildingId = BuildingMapDetailsResult().buildingDetails.elementAt(0).buildingId;
      axisCount = BuildingMapDetailsResult().buildingDetails.elementAt(0).axisCount;
      PanoramaUrl().imageUrl = "http://127.0.0.1:8083/image/$buildingId/$floorId/$axisCount/$xCoordinate/$yCoordinate";
      print(currIndex);
    });
  }

  void _prevImage() {
    setState(() {
      currIndex=currIndex+3;
      if(currIndex >= DirectionDotResult().directionDots.length){
        currIndex=DirectionDotResult().directionDots.length-1;
      }
      xCoordinate = DirectionDotResult().directionDots.elementAt(currIndex).x;
      yCoordinate = DirectionDotResult().directionDots.elementAt(currIndex).y;
      floorId = FloorMapUrl().currentFloor;
      buildingId = BuildingMapDetailsResult().buildingDetails.elementAt(0).buildingId;
      axisCount = BuildingMapDetailsResult().buildingDetails.elementAt(0).axisCount;
      PanoramaUrl().imageUrl = "http://127.0.0.1:8083/image/$buildingId/$floorId/$axisCount/$xCoordinate/$yCoordinate";
      print(currIndex);
    });
  }
  void _onViewChanged(double longitude, double latitude, double tilt) {
    setState(() {
      // Update rotationZ based on longitude
      rotationZ = 1.57 + -1*longitude * (3.141592653589793 / 180.0);
      rotationX = -1.0 + -1*latitude * (3.141592653589793 / 180.0);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Panorama(
            onViewChanged: _onViewChanged,
            onLongPressStart: (longitude, latitude, tilt) => print('onLongPressStart: $longitude, $latitude, $tilt'),
            onLongPressMoveUpdate: (longitude, latitude, tilt) => print('onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
            onLongPressEnd: (longitude, latitude, tilt) => print('onLongPressEnd: $longitude, $latitude, $tilt'),
            child: Image.network(
              PanoramaUrl().imageUrl,
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
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 5 - 75,
            left: MediaQuery.of(context).size.width / 2 - 150,
            child: NavigationButtons(
              onPrevPressed: _prevImage,
              onNextPressed: _nextImage,
              rotationX: rotationX,
              rotationY: rotationY,
              rotationZ: rotationZ,
            ),
          ),
          Positioned(
            top: 50, // Adjust the position as needed
            left: 30, // Adjust the position as needed
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(_customPageRoute('/map'));
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_rounded, // Choose the icon you want
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class NavigationButtons extends StatelessWidget {
  final VoidCallback onPrevPressed;
  final VoidCallback onNextPressed;
  final double rotationX;
  final double rotationY;
  final double rotationZ;

  // Add a GlobalKey for the widget
  final GlobalKey widgetKey = GlobalKey();

  NavigationButtons({
    required this.onPrevPressed,
    required this.onNextPressed,
    required this.rotationX,
    required this.rotationY,
    required this.rotationZ,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      key: widgetKey, // Assign the key to the container
      child: Transform(
        origin: Offset(150, 150),
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..rotateX(rotationX)
          ..rotateY(rotationY)
          ..rotateZ(rotationZ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,

              ),
              child: MaterialButton(
                onPressed: onPrevPressed,
                child: Icon(Icons.arrow_circle_left_outlined , size: 100, color: Colors.white),
                elevation: 0.0,
              ),
            ),
            SizedBox(width: 50),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: MaterialButton(
                onPressed: onNextPressed,
                child: Icon(Icons.arrow_circle_right_outlined, size: 100, color: Colors.white),
                elevation: 0.0,
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Function to get the size of the widget
  Size getSize() {
    final RenderBox renderBox = widgetKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size;
  }
}


//https://github.com/zesage/panorama/blob/master/example/lib/main.dart

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