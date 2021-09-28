import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:offside_yopal/app/ui/pages/calendar/model/Cita.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  late DataSnapshot querySnapshot;
  dynamic data;
  late List<Color> _colorCollection;
  final List<String> options = <String>['Add', 'Delete'];

  @override
  void initState() {
    getDataFromDatabase().then((results) {
      setState(() {
        if (results != null) {
          querySnapshot = results;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton<String>(
          icon: Icon(Icons.settings),
          itemBuilder: (BuildContext context) => options.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList(),
          onSelected: (String value) {
            if (value == 'Add') {
              final dbRef =
                  FirebaseDatabase.instance.reference().child("CalendarData");
              dbRef.push().set({
                "StartTime": '16/09/2021 08:00:00',
                "EndTime": '16/09/2021 09:00:00',
                "Subject": 'Dos',
                "ResourceId": '0002'
              }).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Successfully Added 😎')));
              }).catchError((onError) {});
            } else if (value == 'Delete') {
              final dbRef =
                  FirebaseDatabase.instance.reference().child("CalendarData");
              dbRef.remove();
            }
          },
        ),
      ),
      body: _showCalendar(),
    );
  }

  _showCalendar() {
    if (querySnapshot != null) {
      late List<Cita> collection;
      var showData = querySnapshot.value;
      Map<dynamic, dynamic> values = showData;
      List<dynamic> key = values.keys.toList();
      if (values != null) {
        for (int i = 0; i < key.length; i++) {
          data = values[key[i]];
          collection = <Cita>[];
          final Random random = new Random();
          /*  collection.add(Cita(
              event: data['Subject'],
              diario: true,
              from: DateFormat('dd/MM/yyyy HH:mm:ss').parse(data['StartTime']),
              to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(data['EndTime']),
              background: 'sadasd',
              user: data['ResourceId'])); */
        }
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return SfCalendar(
        view: CalendarView.month,
        initialDisplayDate: DateTime(2021, 09, 16, 9, 0, 0),
        dataSource: MeetingDataSource(_getDataSource(querySnapshot)),
        monthViewSettings: MonthViewSettings(showAgenda: true),
      );
    }
  }
}

List<Cita> _getDataSource(querySnapshot) {
  dynamic data;
  final List<Cita> meetings = <Cita>[];
  final DateTime hoy = DateTime.now();
  final DateTime startTime =
      DateTime(hoy.year, hoy.month, hoy.day + 1, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  var showData = querySnapshot.value;
  Map<dynamic, dynamic> values = showData;
  List<dynamic> key = values.keys.toList();

  if (values != null) {
    for (int i = 0; i < key.length; i++) {
      data = values[key[i]];
      final Random random = new Random();
      /* meetings.add(Cita(
          event: data['Subject'],
          diario: true,
          from: DateFormat('dd/MM/yyyy HH:mm:ss').parse(data['StartTime']),
          to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(data['EndTime']),
          background: 'asd',
          user: data['ResourceId'])); */
    }
  }

  /*  meetings.add(Meeting(
      eventName: 'Conference',
      from: startTime,
      to: endTime,
      background: const Color(0xFF0F8644),
      isAllDay: false,
      resourceId: '02')); */
  return meetings;
}
/* MeetingDataSource _getCalendarDataSource([List<Cita> collection]) {
  List<Cita> meetings = collection ?? <Cita>[];
  List<CalendarResource> resourceColl = <CalendarResource>[];
  resourceColl.add(CalendarResource(
    displayName: 'John',
    id: '0001',
    color: Colors.red,
  ));
  return MeetingDataSource(meetings, resourceColl);
} */

class MeetingDataSource extends CalendarDataSource {
  /* MeetingDataSource(List<Cita> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  } */

  MeetingDataSource(List<Cita> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  List<Object> getResourceIds(int index) {
    return [appointments![index].resourceId];
  }
}

getDataFromDatabase() async {
  var value = FirebaseDatabase.instance.reference();
  var getValue = await value.child('CalendarData').once();
  return getValue;
}
