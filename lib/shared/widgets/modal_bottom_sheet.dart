import 'package:carrinho_de_compras/modules/cart/cart_controller.dart';
import 'package:carrinho_de_compras/modules/cart/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'cart_button_widget.dart';

class ModalBottomSheet extends StatelessWidget {
  final CartItem item;
  final CartController controller;

  const ModalBottomSheet({
    Key? key,
    required this.item,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.product.name),
                Observer(
                  builder: (_) => Container(
                    child: Text("${item.quantity}"),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        item.increment();
                      },
                    ),
                    TextButton(
                      child: Icon(Icons.remove),
                      onPressed: () {
                        item.decrement();
                      },
                    ),
                  ],
                ),
              ],
            ),
            CartButtonWidget(
              buttonText: "Update Cart",
              onPressed: () {
                controller.totalValue;
                item.quantity;
                item.total;
                Navigator.pop(context);
              },
            ),
            CartButtonWidget(
                onPressed: () {
                  controller.removeProduct(item);
                  Navigator.pop(context);
                },
                buttonText: "Remove Product"),
          ],
        ),
      ),
    );
  }
}
