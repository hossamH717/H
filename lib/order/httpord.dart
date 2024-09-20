import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_3/order/ordjson.dart';

class ApiServiceord {
  static Future<List<Jsonapiord>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://192.168.43.177:45455/api/Ords'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Jsonapiord.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // دالة لإضافة طلب جديد إلى قاعدة البيانات
  // static Future<void> addOrder(Jsonapiord product) async {
  //   final response = await http.post(
  //     Uri.parse('http://172.17.37.57:45465/api/Ords'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: json.encode(product.toJson()),
  //   );

  //   if (response.statusCode != 201) {
  //     print('Failed to add order: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //     throw Exception('Failed to add order');
  //   }
  // }

  // static fetchOrders() {}
}
