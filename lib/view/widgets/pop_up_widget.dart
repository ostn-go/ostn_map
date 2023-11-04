import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:flutter/material.dart';

class PopUpContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.only(
        left: 0.0,
        top: 0.0,
        right: 0.0,
        bottom: 0.0,
      ),
      color: Global.fontBlack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pop-up Content'),
          // Add more widgets here
        ],
      ),
    );
  }
}
