import 'package:shopping_app/model/product_model.dart';

class CartProductSummary {
  String? orderId;
  List<CartProductModel> cartProductsList;
  DateTime? orderCreatedAt;
  String totalPrice;

  CartProductSummary({
    this.orderId,
    this.orderCreatedAt,
    this.totalPrice = "0",
    required this.cartProductsList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'cartProductsList': cartProductsList.map((x) => x.toMap()).toList(),
      'orderCreatedAt': orderCreatedAt?.millisecondsSinceEpoch,
      'totalPrice': totalPrice,
    };
  }

  factory CartProductSummary.fromMap(Map<String, dynamic> map) {
    return CartProductSummary(
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      cartProductsList: List<CartProductModel>.from(
        (map['cartProductsList'] as List<int>).map<CartProductModel>(
          (x) => CartProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      orderCreatedAt: map['orderCreatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (map['orderCreatedAt'] ?? 0) as int)
          : null,
      totalPrice: (map['totalPrice'] ?? '') as String,
    );
  }
}

class CartProductModel {
  int quantity;
  ProductModel product;
  CartProductModel({
    required this.quantity,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'product': product.toMap(),
    };
  }

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      quantity: (map['quantity'] ?? 0) as int,
      product: ProductModel.fromMap(map['product'] as Map<String, dynamic>),
    );
  }
}
