import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/cart/model/cart_product_model.dart';
import 'package:shopping_app/utility/firebase_current_user_data.dart';
import 'package:shopping_app/utility/firebase_path.dart';

class MyOrderRepository {
  final _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<CartProductSummary>> streamrOrdersLog() {
    return _firebaseFirestore
        .collection(FirebasePath.user)
        .doc(FirebaseCurrentUserData().userDetails!.uid)
        .collection(FirebasePath.orders)
        .orderBy('orderCreatedAt', descending: true)
        .snapshots()
        .map(
          (snaps) => snaps.docs
              .map((doc) => CartProductSummary.fromMap(doc.data()))
              .toList(),
        );
  }
}