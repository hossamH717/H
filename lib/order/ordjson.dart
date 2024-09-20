import 'dart:convert';
import 'dart:typed_data';

class Jsonapiord {
  final int id; // ID of the product
  final String name; // Name of the product
  final double price; // Price of the product
  final Uint8List image; // Image in Uint8List format
  final DateTime createdAt; // Creation date of the product

  Jsonapiord({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.createdAt,
  });

  factory Jsonapiord.fromJson(Map<String, dynamic> json) {
    return Jsonapiord(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(), // Convert to double
      image: base64Decode(json['image']), // Decode Base64 image to Uint8List
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': base64Encode(image), // Convert Uint8List to Base64 string
      'price': price,
      'createdAt':
          createdAt.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }
}
