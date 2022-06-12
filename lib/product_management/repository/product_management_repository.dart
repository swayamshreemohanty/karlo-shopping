import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/model/product_model.dart';

class ProductManagementRepository {
  final _allProductsPath = FirebaseFirestore.instance.collection('AllProducts');

  Future<void> addProduct({required ProductModel productModel}) async {
    try {
      final productDocRef = _allProductsPath.doc();
      productModel.productId = productDocRef.id;
      await _allProductsPath.doc(productModel.productId).set(productModel.toMap());
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editProduct({required ProductModel productModel}) async {
    try {
      await _allProductsPath
          .doc(productModel.productId)
          .update(productModel.toMap());

      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct({required ProductModel productModel}) async {
    try {
      await _allProductsPath.doc(productModel.productId).delete();

      return;
    } catch (e) {
      rethrow;
    }
  }
}
