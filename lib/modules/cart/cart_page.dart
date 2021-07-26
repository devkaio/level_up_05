import 'package:carrinho_de_compras/modules/cart/cart_controller.dart';
import 'package:carrinho_de_compras/shared/widgets/bottom_total_widget.dart';
import 'package:carrinho_de_compras/shared/widgets/modal_bottom_sheet.dart';
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
            return Center(child: Text('Ops! Seu carrinho está vazio.'));
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
                        builder: (_) => Text((item.total).reais()),
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return ModalBottomSheet(
                              item: item, controller: controller);
                        },
                      );
                    },
                  );
                });
          }
        },
      ),
      bottomSheet: Observer(
        builder: (_) => BottomTotalWidget(
          controller: controller.totalValue.reais(),
        ),
      ),
    );
  }
}
