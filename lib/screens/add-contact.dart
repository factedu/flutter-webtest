import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  final String uid;
  AddContact({Key key, @required this.uid}) : super(key: key);
  @override
  _AddContactState createState() => _AddContactState(uid);
}

class _AddContactState extends State<AddContact> {
  final String uid;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CollectionReference contactsCollection =
      Firestore.instance.collection('contacts');
  TextEditingController _nameController, _numberController;
  String _typeSelected = '';

  _AddContactState(this.uid);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
  }

  Widget _buildContactType(String title) {
    return InkWell(
      child: Container(
        height: 20,
        width: 90,
        decoration: BoxDecoration(
          color: _typeSelected == title
              ? Colors.green
              : Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child:
              Text(title, style: TextStyle(fontSize: 14, color: Colors.white)),
        ),
      ),
      onTap: () {
        setState(() {
          _typeSelected = title;
        });
      },
    );
  }

  _saveContact() {
    String name = _nameController.text;
    String number = _numberController.text;
    String type = _typeSelected;
    if (type.isEmpty) {
      type = 'Others';
    }
    contactsCollection
        .document(uid)
        .collection('contact')
        .add({'name': name, 'number': number, 'type': type}).whenComplete(
            () => Navigator.of(context).pop());
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  prefixIcon: Icon(
                    Icons.account_circle,
                    size: 30,
                    // color: Theme.of(context).primaryColor,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Name is required';
                  }
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _numberController,
                decoration: InputDecoration(
                  hintText: 'Enter Number',
                  prefixIcon: Icon(
                    Icons.phone_iphone,
                    size: 30,
                    // color: Theme.of(context).primaryColor,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Number is required';
                  }
                },
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 50),
              Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _buildContactType('Work'),
                    SizedBox(width: 5),
                    _buildContactType('Family'),
                    SizedBox(width: 5),
                    _buildContactType('Friends'),
                    SizedBox(width: 5),
                    _buildContactType('Others'),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  child: Text(
                    'Save Contact',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _saveContact();
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
