import 'dart:convert';
import 'package:flutter_application_3/shoes/jsonapi.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Jsonapi>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://192.168.43.177:45455/api/Pros'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Jsonapi.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
