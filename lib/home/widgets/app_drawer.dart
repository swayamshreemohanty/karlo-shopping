// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/authentication/logic/authentication/google_authentication_bloc.dart';

class AppDrawer extends StatelessWidget {
  final User userDetails;
  const AppDrawer({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.indigo),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('${userDetails.photoURL}'),
            ),
            accountName: Text(
              '${userDetails.displayName}',
            ),
            accountEmail: Text(
              '${userDetails.email}',
            ),
          ),
          Card(
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text('Log Out'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Are you sure!"),
                    content: const Text("You are about to logout!"),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context
                              .read<GoogleAuthenticationBloc>()
                              .add(LoggedOut(context: context));
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
