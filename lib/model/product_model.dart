class ProductModel {
  String? productId;
  String productImageUrl;
  String productName;
  String productPrice;
  String productDescription;
  ProductModel({
    this.productId,
    required this.productImageUrl,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productImageUrl': productImageUrl,
      'productName': productName,
      'productPrice': productPrice,
      'productDescription': productDescription,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] != null ? map['productId'] as String : '',
      productImageUrl: (map['productImageUrl'] ?? '') as String,
      productName: (map['productName'] ?? '') as String,
      productPrice: (map['productPrice'] ?? '') as String,
      productDescription: (map['productDescription'] ?? '') as String,
    );
  }
  factory ProductModel.blankInitialize() {
    return ProductModel(
      productImageUrl: '',
      productName: '',
      productPrice: '',
      productDescription: '',
    );
  }
}