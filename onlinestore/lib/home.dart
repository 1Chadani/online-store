import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onlinestore/extra.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<Products> products = [];
// get products
Future getProducts() async {
  var response = await http.get(Uri.https('fakestoreapi.com', 'products'));
  // print(response.body);
  var inJson = jsonDecode(response.body);
  for (var eachProduct in inJson) {
    final product = Products(
      title: eachProduct['title'],
      price: eachProduct['price'].toDouble(),
      description: eachProduct['description'],
      image: eachProduct['image'],
    );
    products.add(product);
  }
  // print(products.length);
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    getProducts();
    Size screenSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    double imageHeight = screenSize.width * 0.1;
    double sizeBase = orientation == Orientation.portrait ? 24 : 20;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   toolbarHeight: imageHeight + 16,
      //   title: Row(
      //     children: [
      //       Container(
      //         height: imageHeight,
      //         child: Image.asset('assets/wave.png'),
      //       ),
      //       SizedBox(
      //         width: 12,
      //       ),
      //       Text(
      //         'Hi, Sathi',
      //         style: TextStyle(
      //           color: black,
      //           fontSize: sizeBase,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {},
      //         icon: Icon(
      //           Icons.search,
      //           color: black,
      //           size: sizeBase,
      //         ))
      //   ],
      // ),
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
                future: getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: ListTile(
                              title: Text(products[index].title),
                              subtitle: Text('Rs.' + products[index].price.toString()),
                              leading: products[index].image !=
                                      null // Check if image is not null
                                  ? Image.network(
                                      products[index].image!,
                                      width: 50,
                                      height: 50,
                                    )
                                  : SizedBox(), // Use SizedBox if image is null
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
