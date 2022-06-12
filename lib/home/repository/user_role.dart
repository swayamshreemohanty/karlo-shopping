import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/utility/firebase_current_user_data.dart';
import 'package:shopping_app/utility/firebase_path.dart';

class UserRoleRepository {
  String _userRole = 'user';

  bool get isAdmin => _userRole != 'user';

  Future<void> fetchuserRole() async {
    _userRole = await FirebaseFirestore.instance
        .collection(FirebasePath.user)
        .doc(FirebaseCurrentUserData().userDetails!.uid)
        .get()
        .then(
          (response) => response['role'].toString().toLowerCase(),
        );
  }
}
