import 'package:edqub/controllers/authentication.dart';
import 'package:edqub/screens/contacts.dart';
import 'package:edqub/screens/events.dart';
import 'package:edqub/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './name-generator.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage('assets/edqub_light_logo.png'),
                      ),
                    ),
                  ),
                  Text(
                    'Dev. Contact : factedu@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.local_fire_department),
            title: Text(
              'Startup Name Generator',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return RandomWords();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_phone),
            title: Text(
              'Contacts',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () async {
              FirebaseUser user = await FirebaseAuth.instance.currentUser();
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) {
                  return Contacts(
                    uid: user.uid,
                  );
                }),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today_sharp),
            title: Text(
              'Events',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () async {
              FirebaseUser user = await FirebaseAuth.instance.currentUser();
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) {
                  return Events(
                    uid: user.uid,
                  );
                }),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Sign Out',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => signOutUser().whenComplete(() => Navigator.of(context)
                .pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false)),
          ),
        ],
      ),
    );
  }
}
