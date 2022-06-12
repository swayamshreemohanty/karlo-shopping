

import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer(this.displayName, this.email, this.photoUrl);
  final String displayName;
  final String email;
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('$photoUrl'),
            ),
            accountName: Text(
              '$displayName',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              '$email',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.exit_to_app_rounded),
              title: Text('Log Out'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Are you sure!"),
                    content: Text("You are about to logout!"),
                    actions: [
                      RaisedButton(
                        elevation: 0,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No'),
                      ),
                      RaisedButton(
                        elevation: 0,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                          // FirebaseAuth.instance.signOut();
                          // Provider.of<Authentication>(context, listen: false)
                          //     .signOut(context: context);
                        },
                        child: Text('Yes'),
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
