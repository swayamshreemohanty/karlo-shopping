import 'package:shopping_app/model/product_model.dart';

class CartProductModel {
  String? orderId;
  int quantity;
  ProductModel product;
  DateTime? orderCreatedAt;
  CartProductModel({
    this.orderId,
    required this.product,
    required this.quantity,
    this.orderCreatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'quantity': quantity,
      'product': product.toMap(),
      'orderCreatedAt': orderCreatedAt?.millisecondsSinceEpoch,
    };
  }

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      quantity: (map['quantity'] ?? 1) as int,
      product: ProductModel.fromMap(map['product'] as Map<String, dynamic>),
      orderCreatedAt: map['orderCreatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (map['orderCreatedAt'] ?? 0) as int)
          : null,
    );
  }
}
