class ProductModel {
  final String? id;
  final String name;
  final double price;
  final bool? inCart;
  ProductModel({
    this.id,
    required this.name,
    required this.price,
    this.inCart,
  });

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode;

  @override
  bool operator ==(other) {
    return other is ProductModel &&
        other.id == id &&
        other.name == name &&
        other.price == price;
  }
}
