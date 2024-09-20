import 'dart:convert';
import 'dart:typed_data';

class Jsonapi {
  final int id; // ID of the product
  final String name; // Name of the product
  final double price; // Price of the product
  final Uint8List image; // Image in Uint8List format

  Jsonapi({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory Jsonapi.fromJson(Map<String, dynamic> json) {
    return Jsonapi(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(), // Convert to double
      image: base64Decode(json['image']), // Decode Base64 image to Uint8List
    );
  }
}
