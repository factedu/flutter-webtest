import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edqub/main-drawer.dart';
import 'package:edqub/screens/add-event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Events extends StatefulWidget {
  final String uid;
  Events({Key key, @required this.uid}) : super(key: key);
  @override
  _EventsState createState() => _EventsState(uid);
}

class _EventsState extends State<Events> with TickerProviderStateMixin {
  final String uid;
  CollectionReference eventsCollection =
      Firestore.instance.collection('events');
  AnimationController _animationController;
  CalendarController _calendarController;
  DateTime _selectedDay;
  Map<DateTime, List> _events;
  List _selectedEvents;

  //constructor
  _EventsState(this.uid);

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _selectedDay = DateTime.now();
    _events = {
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
      _selectedDay = day;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TableCalendar(
            calendarController: _calendarController,
            startingDayOfWeek: StartingDayOfWeek.monday,
            initialCalendarFormat: CalendarFormat.week,
            events: _events,
            onDaySelected: _onDaySelected,
            onVisibleDaysChanged: _onVisibleDaysChanged,
            onCalendarCreated: _onCalendarCreated,
            headerStyle: HeaderStyle(
              formatButtonTextStyle:
                  TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
              formatButtonDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            calendarStyle: CalendarStyle(
              selectedColor: Colors.purple[400],
              todayColor: Colors.purple[200],
              markersColor: Colors.green[400],
              outsideDaysVisible: false,
            ),
          ),
          const SizedBox(height: 8.0),
          // _buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_alert_rounded, color: Colors.white),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddEvent(uid: uid, date: _selectedDay);
          }));
        },
      ),
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
