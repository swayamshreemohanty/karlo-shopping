import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/cart/model/cart_product_model.dart';
import 'package:shopping_app/utility/firebase_current_user_data.dart';

class CheckOutRepository {
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addProductsFromCartToOrder(
      {required CartProductSummary cartProducts}) async {
    try {
      final order = _firebaseFirestore
          .collection('user')
          .doc(FirebaseCurrentUserData().userDetails!.uid)
          .collection('orders');
      final orderDocRefs = order.doc();
      cartProducts.orderId = orderDocRefs.id;
      await order.doc(cartProducts.orderId).set(cartProducts.toMap());
      return;
    } catch (error) {
      rethrow;
    }
  }
}
