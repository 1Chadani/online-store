import 'package:flutter/material.dart';

Color black = Colors.black;

class Products {
  final String title;
  final dynamic price;
  final String description;
  final String? image;

  Products(
      {required this.title,
      required this.price,
      required this.description,
      this.image
      });
}
