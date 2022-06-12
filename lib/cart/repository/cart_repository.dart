import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/cart/model/cart_product_model.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/utility/firebase_current_user_data.dart';
import 'package:shopping_app/utility/firebase_path.dart';

class CartRepository {
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> isProductAlreadyInCart({required String productId}) async {
    final existingProduct = await _firebaseFirestore
        .collection(FirebasePath.user)
        .doc(FirebaseCurrentUserData().userDetails!.uid)
        .collection(FirebasePath.cart)
        .doc(productId)
        .get();

    if (existingProduct.data() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<CartProductModel>> fetchCartProductsFromServerCart() async {
    try {
      return await _firebaseFirestore
          .collection(FirebasePath.user)
          .doc(FirebaseCurrentUserData().userDetails!.uid)
          .collection(FirebasePath.cart)
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
      {required ProductModel product}) async {
    try {
      final existingProductsOnCart = await fetchCartProductsFromServerCart();
      if (existingProductsOnCart.isNotEmpty) {
        for (var cartproduct in existingProductsOnCart) {
          if (cartproduct.product.productId == product.productId) {
            cartproduct.quantity += cartproduct.quantity + 1;
          }
        }
      }
      await _firebaseFirestore
          .collection(FirebasePath.user)
          .doc(FirebaseCurrentUserData().userDetails!.uid)
          .collection(FirebasePath.cart)
          .doc(product.productId)
          .delete();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProductToServerCart({required ProductModel product}) async {
    try {
      final cartProduct = CartProductModel(product: product, quantity: 1);

      await _firebaseFirestore
          .collection(FirebasePath.user)
          .doc(FirebaseCurrentUserData().userDetails!.uid)
          .collection(FirebasePath.cart)
          .doc(cartProduct.product.productId)
          .set(cartProduct.toMap());
    } catch (error) {
      rethrow;
    }
  }
}
