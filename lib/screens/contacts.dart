import 'package:edqub/main-drawer.dart';
import 'package:edqub/screens/add-contact.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Saved Contacts'),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_call,color: Colors.white),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddContact();
          }));
        },
      ),
    );
  }
}
