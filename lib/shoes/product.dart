import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_3/shoes/jsonapi.dart';
import 'package:flutter_application_3/shoes/http.dart';
import 'package:flutter_application_3/order/orderpage.dart';

class ProductGridPage extends StatefulWidget {
  @override
  _ProductGridPageState createState() => _ProductGridPageState();
}

class _ProductGridPageState extends State<ProductGridPage> {
  List<Jsonapi> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sport Shoes'),
        backgroundColor: Color(0xFF475269),
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.menu, // أيقونة الدروار
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              // Add onPressed action for notifications here
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 55,
                decoration: BoxDecoration(
                  color: Color(0xfff5f9fd),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFF5F9FD).withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search,
                      size: 27,
                      color: Color(0xff475269),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              FutureBuilder<List<Jsonapi>>(
                future: ApiService.fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child:
                            Text('Failed to load products: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No products available'));
                  } else {
                    final products = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            product: product,
                            onAddToCart: () {
                              setState(() {
                                cartItems.add(product);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${product.name} has been added to the cart.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xff475269),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.category_outlined,
            color: Colors.white,
            size: 32,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderPage(cartItems: cartItems),
                ),
              );
            },
            child: Icon(
              CupertinoIcons.cart_fill,
              color: Colors.white,
              size: 32,
            ),
          ),
          Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: 32,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
            size: 32,
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Jsonapi product;
  final VoidCallback onAddToCart;

  ProductCard({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                product.image,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 30),
            Text(
              product.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 17, color: Colors.red),
                ),
                GestureDetector(
                  onTap: onAddToCart,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xff475269),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      CupertinoIcons.cart_badge_plus,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
