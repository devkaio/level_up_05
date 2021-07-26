import 'package:carrinho_de_compras/modules/cart/cart_controller.dart';
import 'package:carrinho_de_compras/modules/cart/cart_page.dart';
import 'package:carrinho_de_compras/modules/cart/cart_item.dart';
import 'package:carrinho_de_compras/modules/home/home_controller.dart';
import 'package:carrinho_de_compras/shared/models/product_model.dart';
import 'package:carrinho_de_compras/shared/widgets/appbar_cart_widget.dart';
import 'package:carrinho_de_compras/shared/widgets/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:carrinho_de_compras/shared/utils/extensions.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final cartController = CartController();

  @override
  void initState() {
    controller.getProducts();
    super.initState();
  }

  void updateCart(ProductModel product) {
    if (cartController.contains(product)) {
      cartController.removeProduct(
        CartItem(product),
      );
    } else {
      cartController.addProduct(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping page"),
        actions: [
          Observer(
            builder: (_) => AppBarCartWidget(
              controller: cartController,
              itemCounter: cartController.itemsCount.toString(),
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.appStatus == AppStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.appStatus == AppStatus.success) {
            return ListView.builder(
              itemCount: controller.products.length,
              itemBuilder: (_, index) {
                final product = controller.products[index];
                return ProductTile(
                  title: Text(controller.products[index].name),
                  price: Text(controller.products[index].price.reais()),
                  value: cartController.contains(product) ? true : false,
                  onChanged: (value) {
                    setState(() {});
                    updateCart(product);
                  },
                );
              },
            );
          } else if (controller.appStatus == AppStatus.empty) {
            return EmptyState();
          } else if (controller.appStatus == AppStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Houve um problema",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: Colors.red),
                  ),
                  Text(
                    controller.errorMessage.isNotEmpty
                        ? controller.errorMessage
                        : controller.appStatus.message(),
                  ),
                ],
              ),
            );
          }
          return EmptyState();
        },
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Produtos indisponíveis no momento!",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
