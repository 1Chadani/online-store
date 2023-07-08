import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductService {
  static List<Products> products = [];
// get products
  Future<List<Products>> getProducts({String? query}) async {
    products.clear();
    var response = await http.get(Uri.https('fakestoreapi.com', 'products'));
    // print(response.body);
    try {
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
        if(query != null){
          products = products.where((product) => product.title.toLowerCase().contains(query.toLowerCase())).toList();
        }
        return products;
    } catch (e) {
      print('Error occur: $e');
    }
    return [];
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
