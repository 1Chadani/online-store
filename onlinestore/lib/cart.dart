import 'package:flutter/material.dart';
import 'package:onlinestore/product.dart';
import 'package:provider/provider.dart';

import 'extra.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // Access the CartModel using Provider
    CartModel cartModel = context.watch<CartModel>();
    List<Products> cartItems = cartModel.cartItems;
    

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Cart',
            style: TextStyle(color: black),
          ),
          backgroundColor: appThemeColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: black,
              )),
        ),
        body: Container(
          color: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              Products product = cartItems[index];

              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Image.network(
                    product.image!,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(product.title),
                  subtitle: Text('\Rs. ${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () => cartModel.removeItemFromCart(index),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
