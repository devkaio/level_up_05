import 'package:carrinho_de_compras/modules/cart/cart_controller.dart';
import 'package:carrinho_de_compras/modules/cart/cart_page.dart';
import 'package:flutter/material.dart';

class AppBarCartWidget extends StatelessWidget {
  const AppBarCartWidget({
    Key? key,
    required this.controller,
    required this.itemCounter,
  }) : super(key: key);

  final CartController controller;
  final String itemCounter;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CartPage(
              controller: controller,
            ),
          ),
        );
      },
      icon: Stack(
        children: [
          Icon(
            Icons.shopping_cart,
            size: 30,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 9,
              child: Text(
                itemCounter,
                style: TextStyle(fontSize: 8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
