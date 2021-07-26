import 'package:carrinho_de_compras/modules/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:carrinho_de_compras/shared/utils/extensions.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CartPage extends StatelessWidget {
  final CartController controller;

  CartPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Observer(
        builder: (_) {
          if (controller.list.isEmpty) {
            return Center(
              child: Text('Ops! Seu carrinho está vazio.'),
            );
          } else {
            return ListView.builder(
                itemCount: controller.list.length,
                itemBuilder: (_, index) {
                  final item = controller.list[index];
                  return GestureDetector(
                    child: ListTile(
                      title: Text(item.product.name),
                      subtitle: Observer(
                        builder: (_) => Text((item.product.price).reais() +
                            " x " +
                            "${item.quantity}"),
                      ),
                      trailing: Observer(
                        builder: (_) => Text(
                          (item.total).reais(),
                        ),
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(item.product.name),
                                      Observer(
                                        builder: (_) => Container(
                                          child: Text("${item.quantity}"),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                  ElevatedButton(
                                    child: Text('Update cart'),
                                    onPressed: () {
                                      controller.totalValue;
                                      controller.itemsCount;
                                      item.quantity;
                                      item.total;
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text('Remove Product'),
                                    onPressed: () {
                                      controller.removeProduct(item);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                });
          }
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: ",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Observer(
              builder: (_) => Text(
                controller.totalValue.reais(),
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
