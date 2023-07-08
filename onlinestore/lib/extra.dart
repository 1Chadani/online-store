import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductService {
  static List<Products> products = [];
// get products
  Future<List<Products>> getProducts({String? query}) async {
    var response = await http.get(Uri.https('fakestoreapi.com', 'products'));
    // print(response.body);
    try {
      if (response.statusCode == 200) {
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
        // print(products.length);
      } else {
        print('Error occur while fetching data');
      }
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
