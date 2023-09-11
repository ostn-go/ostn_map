import 'package:custom_zoomable_floorplan/core/models/models.dart';
import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
class GridViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final model = Provider.of<FloorPlanModel>(context);
    final arrayM = Global.floorPlan;

    // final arrayM1 = ['wall','floor','floor','wall','floor','wall','wall','floor','wall'];
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
                    color: arrayM[currentTile-1] == 0 ? Global.backgroundBlack : arrayM[currentTile-1] == 1 ? Global.wallBlack : Global.pathBlack,
                  ),
                  if(Global.labelMap[currentTile-1] != null)
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 5.0,
                      child: Center(
                        child: Icon(
                          Icons.dining,
                          color: Global.blue,
                          size: 7,
                        ),
                      ),
                    ),
                  if(Global.labelMap[currentTile-1] != null)
                    Transform(
                      transform: Matrix4.identity()..translate(18.0),
                      child: Text(
                        'Dining',
                        style: TextStyle(
                          fontSize: 6.0,
                          color: Colors.white,
                        ),
                      ),
                  )
                ],
              );
            },
          ),

          Stack(
            children: List.generate(
              4,
                  (idx) {
                return Transform.translate(
                  offset: Offset(
                    size.width * 0.0,
                    size.width * 0.0,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 5.0,
                        child: Center(
                          child: Icon(
                            Icons.dining,
                            color: Global.blue,
                            size: 7,
                          ),
                        ),
                      ),
                      Transform(
                        transform: Matrix4.identity()..translate(18.0),
                        child: Text(
                          'Dining',
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
