import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/home/repository/user_role.dart';
import 'package:shopping_app/home/widgets/app_drawer.dart';
import 'package:shopping_app/utility/firebase_current_user_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<UserRoleRepository>().fetchuserRole();
    super.initState();
  }

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
