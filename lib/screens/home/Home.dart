import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/MyUser.dart';
import 'package:first_app/screens/NavigationDrawerWidget.dart';
import 'package:first_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:first_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:duration_picker/duration_picker.dart';

//test commit

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  bool isSwitched = false;
  Duration duration = Duration(hours: 0, minutes: 0);

  @override
  Widget build(BuildContext context) {
    final activeUser = Provider.of<MyUser?>(context);

    return StreamProvider<QuerySnapshot?>.value(
        value: DatabaseService().users,
        initialData: null,
        child: Scaffold(
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            title: Text('Devices List'),
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
            actions: <Widget>[
              TextButton.icon(
                label: Text('Add device', style: TextStyle(color: Colors.black)),
                icon: Icon(
                  Icons.add_box_outlined,
                  color: Colors.black,
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
          drawer: NavigationDrawerWidget(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Switch(
                    value: isSwitched,
                    onChanged: (val) {
                      setState(() {
                        isSwitched = val;
                        DatabaseService(uid: activeUser?.uid).updateLigthState(val);
                      });
                    }),
                Expanded(
                    child: DurationPicker(
                  duration: duration,
                  onChange: (val) {
                    setState(() {
                      duration = val;
                      DatabaseService(uid: activeUser?.uid)
                          .updateUserDuration(duration);
                    });
                  },
                  snapToMins: 1.0,
                ))
              ],
            ),
          ),
        ));
  }
}
