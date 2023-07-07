import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductService {
  static List<Products> products = [];
// get products
  static Future<List<Products>> getProducts() async {
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
    return products;
    // print(products.length);
  }
}

Color black = Colors.black;
Color backgroundColor = Colors.grey[200]!;
const textWeight = FontWeight.bold;
Color appThemeColor = Colors.lightGreenAccent;
class Products {
  final String title;
  final dynamic price;
  final String description;
  final String? image;

  Products(
      {required this.title,
      required this.price,
      required this.description,
      this.image});
}
