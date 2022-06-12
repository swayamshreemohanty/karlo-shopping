class ProductModel {
  String? productId;
  String productImageUrl;
  String productName;
  String productPrice;
  String productDescription;
  DateTime createdAt;
  ProductModel({
    this.productId,
    required this.productImageUrl,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productImageUrl': productImageUrl,
      'productName': productName,
      'productPrice': productPrice,
      'productDescription': productDescription,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] != null ? map['productId'] as String : null,
      productImageUrl: (map['productImageUrl'] ?? '') as String,
      productName: (map['productName'] ?? '') as String,
      productPrice: (map['productPrice'] ?? '') as String,
      productDescription: (map['productDescription'] ?? '') as String,
      createdAt:
          DateTime.fromMillisecondsSinceEpoch((map['createdAt'] ?? 0) as int),
    );
  }
  factory ProductModel.blankInitialize() {
    return ProductModel(
      productImageUrl: '',
      productName: '',
      productPrice: '',
      productDescription: '',
      createdAt: DateTime.now(),
    );
  }
}