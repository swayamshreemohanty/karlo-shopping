class CartProductModel {
  String? orderId;
  String productId;
  String productImageUrl;
  String productName;
  String productPrice;
  String productDescription;
  DateTime orderCreatedAt;
  CartProductModel({
    this.orderId,
    required this.productId,
    required this.productImageUrl,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.orderCreatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'productId': productId,
      'productImageUrl': productImageUrl,
      'productName': productName,
      'productPrice': productPrice,
      'productDescription': productDescription,
      'orderCreatedAt': orderCreatedAt.millisecondsSinceEpoch,
    };
  }

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      productId: (map['productId'] ?? '') as String,
      productImageUrl: (map['productImageUrl'] ?? '') as String,
      productName: (map['productName'] ?? '') as String,
      productPrice: (map['productPrice'] ?? '') as String,
      productDescription: (map['productDescription'] ?? '') as String,
      orderCreatedAt: DateTime.fromMillisecondsSinceEpoch(
          (map['orderCreatedAt'] ?? 0) as int),
    );
  }
}