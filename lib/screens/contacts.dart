import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edqub/main-drawer.dart';
import 'package:edqub/screens/add-contact.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  final String uid;
  Contacts({Key key, @required this.uid}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState(uid);
}

class _ContactsState extends State<Contacts> {
  final String uid;
  CollectionReference contactsCollection =
      Firestore.instance.collection('contacts');

  _ContactsState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Saved Contacts'),
      ),
      drawer: MainDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            contactsCollection.document(uid).collection('contact').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      ds['name'],
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(ds['number']),
                    trailing: Text(ds['type']),
                    onLongPress: () => {
                      contactsCollection
                          .document(uid)
                          .collection('contact')
                          .document(ds.documentID)
                          .delete()
                    },
                  ),
                );
              },
            );
          } else {
            return Text('No contacts to display');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_call, color: Colors.white),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddContact(
              uid: uid,
            );
          }));
        },
      ),
    );
  }
}
