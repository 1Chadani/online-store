import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // get product
  Future getProduct() async{
    var response = await http.get(Uri.https('fakestoreapi.com', 'products'));
    print(response.body);
  }
  @override
  Widget build(BuildContext context) {
    getProduct();
    return Scaffold();
  }
}