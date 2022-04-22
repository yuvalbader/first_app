import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/MyUser.dart';

import 'package:flutter/material.dart';
import 'package:first_app/services/database.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatelessWidget {
  NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
        final activeUser = Provider.of<MyUser?>(context);

    return StreamProvider<QuerySnapshot?>.value(
        value: DatabaseService().users,
        initialData: null,
        child: Drawer(
      child: Material(
          color: Colors.blue[600],
          child: ListView(
            padding: padding,
            children: <Widget>[
              DrawerHeader(
                child: Container(
                    child: Column(
                  children: <Widget>[
                    // Material(
                    //   borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    //   child: Image.asset('assets\images\logo.png',
                    //       height: 100, width: 100),
                    // ),
                    Text('User', style: TextStyle(color: Colors.black)),
                    Text(activeUser?.email?? 'Anonymous User',
                        style: TextStyle(color: Colors.red)),
                  ],
                )),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                  Colors.blueAccent,
                  Colors.lightBlue,
                ])),
              ),
              const SizedBox(height: 48),
              buildMenuItem(text: 'Add user', icon: Icons.person_add_alt),
              const SizedBox(height: 48),
              buildMenuItem(text: 'My Devices', icon: Icons.list),
              const SizedBox(height: 48),
              buildMenuItem(text: 'Settings', icon: Icons.settings),
              const SizedBox(height: 48),
              buildMenuItem(text: 'Support', icon: Icons.support_agent),
              const SizedBox(height: 48),
              buildMenuItem(text: 'About', icon: Icons.info),
              const SizedBox(height: 48),
              buildMenuItem(text: 'LogOut', icon: Icons.logout)
            ],
          )),
    ));
  }
}

Widget buildMenuItem({required String text, required IconData icon}) {
  final color = Colors.white;
  final hoverColor = Colors.white70;

  return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: () {});
}
