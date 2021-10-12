import 'package:flutter/cupertino.dart';

import '../model/Cita.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Cita> source) {
    this.appointments = source;
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
