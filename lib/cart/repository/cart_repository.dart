import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/cart/model/cart_item_model.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/utility/firebase_current_user_data.dart';

class CartRepository {
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<CartProductModel>> fetchCartProductsFromServerCart() async {
    try {
      return await _firebaseFirestore
          .collection('user')
          .doc(FirebaseCurrentUserData().userDetails!.uid)
          .collection('cart')
          .get()
          .then(
            (response) => response.docs
                .map((e) => CartProductModel.fromMap(e.data()))
                .toList(),
          );
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteProductsFromServerCart(
      {required ProductModel productModel}) async {
    try {
      await _firebaseFirestore
          .collection('user')
          .doc(FirebaseCurrentUserData().userDetails!.uid)
          .collection('cart')
          .doc(productModel.productId)
          .delete();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProductToServerCart(
      {required ProductModel productModel}) async {
    try {
      await _firebaseFirestore
          .collection('user')
          .doc(FirebaseCurrentUserData().userDetails!.uid)
          .collection('cart')
          .doc(productModel.productId)
          .set(productModel.toMap());
    } catch (error) {
      rethrow;
    }
  }
}
