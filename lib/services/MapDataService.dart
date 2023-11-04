
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../core/models/models.dart';
import '../core/viewmodels/floorplan_model.dart';

Future<List<dynamic>> fetchData() async {
  final response = await http.get(Uri.parse('http://localhost:8081/ostn/map/1001'));
  if (response.statusCode == 200) {
    // Parse the JSON response if successful
    final data = jsonDecode(response.body);

    return data['map'];
  } else {
    return [];
  }


}

Future<List<dynamic>> fetchLabels() async {
  final response = await http.get(Uri.parse('http://localhost:8082/ostn/label/get/1001'));
  if (response.statusCode == 200) {
    // Parse the JSON response if successful
    final data = jsonDecode(response.body);

    return data;
  } else {
    return [];
  }


}

Future<List<dynamic>> fetchBuildingMap() async {
  final response = await http.get(Uri.parse('http://localhost:8082/ostn/building/1001/'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    return data;
  } else {
    return [];
  }
}

Future<List<dynamic>> fetchTransportDetails() async {
  final response = await http.get(Uri.parse('http://localhost:8082/ostn/transport_mode/1001'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    return data;
  } else {
    return [];
  }
}


Future<dynamic> fetchUserLocation(List<BleUserPosition> bleUserInputs) async {
  final Map<String, String> headers = {
    'Content-Type': 'application/json', // Adjust content type as needed
  };

  final Map<String, dynamic> data = {
    // Add more key-value pairs as needed
  };

  // Encode the request body as JSON
  final String requestBody = jsonEncode(bleUserInputs);
  final response = await http.post(
    Uri.parse('http://localhost:8080/triangulate_demo'),
    headers: headers,
    body: requestBody,);
  if (response.statusCode == 200) {
    // Parse the JSON response if successful
    final data = jsonDecode(response.body);

    return data;
  } else {
    return [];
  }


}

Future<dynamic> fetchUserLocation_1(List<BleUserPosition> bleUserInputs) async {
  final Map<String, String> headers = {
    'Content-Type': 'application/json', // Adjust content type as needed
  };

  // Encode query parameters
  final Map<String, dynamic> queryParameters = {
    // Add query parameters as needed
  };

  // Build the URL with query parameters
  final Uri uri = Uri.parse('http://localhost:8080/triangulate_demo')
      .replace(queryParameters: queryParameters);

  final response = await http.get(
    uri,
    headers: headers,
  );

  if (response.statusCode == 200) {
    // Parse the JSON response if successful
    final data = jsonDecode(response.body);

    return data;
  } else {
    return [];
  }
}


Future<dynamic> fetchDirectionDots(DirectionDotRequest directionDotRequest) async {
  final Map<String, String> headers = {
    'Content-Type': 'application/json', // Adjust content type as needed
  };

  String json = jsonEncode(directionDotRequest.toJson());
  final response = await http.post(
    Uri.parse('http://127.0.0.1:5000/pathCoordinates'),
    headers: headers,
    body: json,);
  if (response.statusCode == 200) {
    // Parse the JSON response if successful
    final data = jsonDecode(response.body);

    return data;
  } else {
    return [];
  }


}