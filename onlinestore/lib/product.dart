import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onlinestore/cart.dart';
import 'package:onlinestore/extra.dart';
import 'package:provider/provider.dart';

class CartModel extends ChangeNotifier {
  List<Products> cartItems = [];

  void addToCart(Products product) {
    cartItems.add(product);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
      cartItems.removeAt(index);
      notifyListeners();
    }
  bool contains(Products product) {
    return cartItems.contains(product);
  }
}

class ProductDetail extends StatefulWidget {
  final Products product;

  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: black,
            )),
        actions: [
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: IconButton(
                  onPressed: () {
                    Get.to(() => CartPage());
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: black,
                  )))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Image.network(
                widget.product.image!,
                width: 200,
                height: 200,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30, right: 14, left: 14),
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: textWeight,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '\Rs.',
                            style:
                                TextStyle(fontSize: 16, fontWeight: textWeight),
                          ),
                          Text(
                            widget.product.price.toStringAsFixed(2),
                            style:
                                TextStyle(fontSize: 20, fontWeight: textWeight),
                          ),
                        ],
                      ),
                      Divider(color: Colors.green),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: textWeight,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.product.description,
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Access the CartModel using Provider
          CartModel cartModel = context.read<CartModel>();

          if (!cartModel.contains(widget.product)) {
            // Add the selected product to the cart
            cartModel.addToCart(widget.product);
            Fluttertoast.showToast(
              msg: "Added to cart successfully",
              backgroundColor: Colors.green,
              fontSize: 16.0,
            );
          } else {
            Fluttertoast.showToast(
              msg: "Item already added",
              backgroundColor: Colors.red,
              fontSize: 16.0,
            );
          }
        },
        label: const Text(
          'Add to cart',
          style: TextStyle(color: Colors.black),
        ),
        icon: const Icon(
          Icons.check,
          color: Colors.black,
        ),
        backgroundColor: appThemeColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
