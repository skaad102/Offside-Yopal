import 'package:flutter/material.dart';
import 'package:offside_yopal/app/ui/pages/calendar/widget/boton_more.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CustomCalendario extends StatefulWidget {
  const CustomCalendario({Key? key}) : super(key: key);

  @override
  _CustomCalendarioState createState() => _CustomCalendarioState();
}

class _CustomCalendarioState extends State<CustomCalendario> {
  late CalendarController _calendarController;
  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SfCalendar(
            timeZone: 'SA Pacific Standard Time',
            controller: _calendarController,
            view: CalendarView.month,
            showDatePickerButton: true,
            onTap: (detalles) {},
          ),
          floatingActionButton: BotonAgregarCita()),
    );
  }
}
