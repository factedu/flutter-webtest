import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  final String uid;
  final DateTime date;
  AddEvent({Key key, @required this.uid, @required this.date})
      : super(key: key);
  @override
  _AddEventState createState() => _AddEventState(uid, date);
}

class _AddEventState extends State<AddEvent> {
  final String uid;
  final DateTime date;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CollectionReference eventsCollection =
      Firestore.instance.collection('events');
  TextEditingController _eventTextController;

  //constructor
  _AddEventState(this.uid, this.date);

  @override
  void initState() {
    super.initState();
    _eventTextController = TextEditingController();
  }

  _saveEvent() {
    String event = _eventTextController.text.trim();
    print({uid, date, event});
    eventsCollection
        .document(uid)
        .collection('event')
        .add({'date': date, 'title': event}).whenComplete(
            () => Navigator.of(context).pop());
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event : ' + date.toLocal().toString()),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _eventTextController,
                // maxLength: 50,
                // maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Enter Event Title',
                  prefixIcon: Icon(
                    Icons.add_alert_rounded,
                    size: 30,
                    // color: Theme.of(context).primaryColor,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Event description is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 50),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  child: Text(
                    'Save Event',
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
                    _saveEvent();
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
