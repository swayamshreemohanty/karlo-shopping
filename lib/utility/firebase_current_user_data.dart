import 'package:firebase_auth/firebase_auth.dart';

class FirebaseCurrentUserData {
  final userDetails = FirebaseAuth.instance.currentUser;
}