import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:custom_zoomable_floorplan/view/widgets/raw_gesture_detector_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;


class RotationGestureDetectorWidget extends StatelessWidget {
  final Widget child;

  RotationGestureDetectorWidget({required this.child});

  @override // overides the build method of the StatelessWidget
  Widget build(BuildContext context) { // Buildcontext contains information on location of widget on the tree
    final Size size = MediaQuery.of(context).size;
    final model = Provider.of<FloorPlanModel>(context);

    //The first line declares a Map called _gestures. The map will store the gestures that are recognized by the widget
    final _gestures = {
      DragAndScale: GestureRecognizerFactoryWithHandlers<DragAndScale>(
            () => DragAndScale(),
            (DragAndScale instance) {
          instance
            ..onStart = (details) {
              model.handleDragScaleStart(details);
            }
            ..onUpdate = (details) {
              model.handleDragScaleUpdate(details);
            }
            ..onEnd = (_) {
              model.handleDragScaleEnd();
            };
        },
      )
    };

    // This code is used to align the object to the centre.
    final AlignmentGeometry _alignment = FractionalOffset.center;

    final Matrix4 _transform = Matrix4.diagonal3(
      Vector3(
        model.scale,
        model.scale,
        model.scale,
      ),
    )
      ..translate(
        model.pos.x,
        model.pos.y,
      );

    return RawGestureDetector(
      gestures: _gestures,
      child: Container(
        color: Colors.transparent,
        child: Transform(
          alignment: _alignment,
          transform: _transform,
          child: ScrollConfiguration(
            behavior: RemoveScrollGlow(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
