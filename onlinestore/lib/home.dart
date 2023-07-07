import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinestore/extra.dart';
import 'package:http/http.dart' as http;
import 'package:onlinestore/product.dart';
import 'package:onlinestore/product.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// List<Products> products = [];
// // get products
// Future getProducts() async {
//   var response = await http.get(Uri.https('fakestoreapi.com', 'products'));
//   // print(response.body);
//   var inJson = jsonDecode(response.body);
//   for (var eachProduct in inJson) {
//     final product = Products(
//       title: eachProduct['title'],
//       price: eachProduct['price'].toDouble(),
//       description: eachProduct['description'],
//       image: eachProduct['image'],
//     );
//     products.add(product);
//   }
//   // print(products.length);
// }

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Products>>? productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = ProductService.getProducts();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    double imageHeight = screenSize.width * 0.1;
    double sizeBase = orientation == Orientation.portrait ? 24 : 20;

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          // floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Colors.lightGreen,
              elevation: 3,
              toolbarHeight: imageHeight + 16,
              floating: true,
              snap: true,
              title: Row(
                children: [
                  Container(
                    height: imageHeight,
                    child: Image.asset('assets/wave.png'),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Hi, Sathi',
                    style: TextStyle(
                      color: black,
                      fontSize: sizeBase,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: black,
                      size: sizeBase,
                    ))
              ],
            )
          ],
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            color: Colors.grey[200],
            child: FutureBuilder(
                future: productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Products product = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ProductDetail(product: product));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: ListTile(
                                title: Text(product.title),
                                subtitle: Text('Rs.' + product.price.toStringAsFixed(2)),
                                leading: product.image !=
                                        null // Check if image is not null
                                    ? Image.network(
                                        product.image!,
                                        width: 50,
                                        height: 50,
                                      )
                                    : SizedBox(), // Use SizedBox if image is null
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
