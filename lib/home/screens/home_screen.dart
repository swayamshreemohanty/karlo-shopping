import 'package:flutter/material.dart';
import 'package:shopping_app/home/widgets/app_drawer.dart';
import 'package:shopping_app/utility/firebase_current_user_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Karlo Shopping"),
          centerTitle: true,
          elevation: 0,
        ),
        drawer: AppDrawer(
          userDetails: FirebaseCurrentUserData().userDetails!,
        ),
      );
}