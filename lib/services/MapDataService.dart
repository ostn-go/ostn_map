
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

