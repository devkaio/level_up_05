import 'package:carrinho_de_compras/shared/models/product_model.dart';
import 'package:carrinho_de_compras/shared/utils/extensions.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'dart:math';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  String errorMessage = " ";
  int randomPrice = Random().nextInt(10) + 1;

  @observable
  AppStatus appStatus = AppStatus.empty;
  List<ProductModel> products = <ProductModel>[];

  @action
  Future<void> getProducts() async {
    try {
      appStatus = AppStatus.loading;
      products = await Future.delayed(Duration(seconds: 2)).then(
        (value) => List.generate(
          10,
          (index) => ProductModel(
            name: "Produto $index",
            price: randomPrice.toDouble() * index,
          ),
        ),
      );

      appStatus = products.isNotEmpty ? AppStatus.success : AppStatus.empty;
    } on PlatformException catch (e) {
      errorMessage = e.message.toString();
      appStatus = AppStatus.error;
    } catch (e) {
      errorMessage = e.toString();
      appStatus = AppStatus.error;
      appStatus.message();
    }
  }
}
