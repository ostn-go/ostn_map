
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../core/models/models.dart';

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

