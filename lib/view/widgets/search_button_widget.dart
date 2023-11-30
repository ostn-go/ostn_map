import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/CustomSearchDelegate.dart';
import '../shared/global.dart';

class SearchButtonWidget extends StatelessWidget {
  final Function onPressedCallback;

  SearchButtonWidget({required this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
        child: ElevatedButton(
          onPressed: () {
            onPressedCallback();
            // Method to show the search bar
            // showSearch(
            //   context: context,
            //   delegate: CustomSearchDelegate(),
            // );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Global.searchBarBlack, // Grey background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            minimumSize: Size.fromHeight(50.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.search, color: Colors.white), // Search icon
              Text(
                'Search',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 16.0, // Text size
                ),
              ),
              SizedBox(width: 30.0),
              // Add spacing on the right
            ],
          ),
        ),
      ),
    );
  }
}