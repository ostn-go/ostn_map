import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FloorPlanModel>(context);
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Transform.rotate(
          angle: 45 * (3.14159265359 / 180), // Rotate by 45 degrees (in radians)
          child: IconButton(
            onPressed: () {
              model.reset();
            },
            icon: Icon(Icons.assistant_navigation),
            iconSize: 60,
            color: Global.fontBlack,
            padding: const EdgeInsets.all(25.0),
          ),
        ),
      ),
    );
  }
}
