import 'package:flutter/material.dart';
import 'package:flutter_application_3/order/httpord.dart';
import 'package:flutter_application_3/order/ordjson.dart';

import '../shoes/jsonapi.dart';

class OrderPage extends StatelessWidget {
  final List<Jsonapi> cartItems;

  OrderPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
        backgroundColor: Color(0xFF6A748A),
      ),
      body: FutureBuilder<List<Jsonapiord>>(
        future: ApiServiceord.fetchProducts(), // جلب الطلبات من API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Failed to load orders: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders available'));
          } else {
            final orders = snapshot.data!;

            // دمج الطلبات المأخوذة من API مع العناصر المضافة حديثًا
            final allOrders = [
              ...orders,
              ...cartItems.map((product) => Jsonapiord(
                  id: product.id,
                  name: product.name,
                  price: product.price,
                  image: product.image,
                  createdAt:
                      DateTime.now() // Use ISO 8601 string format for date
                  )),
            ];

            return ListView.builder(
              itemCount: allOrders.length,
              itemBuilder: (context, index) {
                final order = allOrders[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      // ignore: unnecessary_null_comparison
                      child: order.image != null
                          ? Image.memory(order.image,
                              width: 50, height: 50, fit: BoxFit.cover)
                          : Icon(Icons.image_not_supported, size: 50),
                    ),
                    title: Text(
                      order.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          '\$${order.price.toStringAsFixed(2)}',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        // SizedBox(height: 5),
                        // Text(
                        //   'Date: ${order.createdAt}', // عرض تاريخ الطلب
                        //   style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
