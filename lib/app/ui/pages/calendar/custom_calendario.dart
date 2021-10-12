import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'dart:math';
import 'package:offside_yopal/app/ui/pages/calendar/controller/add_controller.dart';
import 'package:offside_yopal/app/ui/pages/calendar/widget/boton_more.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'controller/event_data_source.dart';
import 'model/Cita.dart';

class CustomCalendario extends StatefulWidget {
  const CustomCalendario({Key? key}) : super(key: key);

  @override
  _CustomCalendarioState createState() => _CustomCalendarioState();
}

class _CustomCalendarioState extends State<CustomCalendario> {
  late CalendarController _calendarController;
  MeetingDataSource? events;
  bool isInitialLoaded = false;
  List<Color> _colorCollection = <Color>[];
  /* final addCitaController = AddCitaController(); */
  final fireStoreReference = FirebaseFirestore.instance;

  @override
  void initState() {
    _initializeEventColor();
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    fireStoreReference
        .collection("citas_calendario_1")
        .snapshots()
        .listen((event) {
      event.docChanges.forEach((element) {
        Map<String, dynamic>? data = element.doc.data()!;

        if (element.type == DocumentChangeType.added) {
          if (!isInitialLoaded) {
            return;
          }
          final Random color = Random();
          Cita app = Cita.fromJson(data, _colorCollection[color.nextInt(9)]);
          setState(() {
            events!.appointments!.add(app);
            events!.notifyListeners(CalendarDataSourceAction.add, [app]);
          });
        } else if (element.type == DocumentChangeType.modified) {
          if (!isInitialLoaded) return;
        }

        final Random color = Random();
        Cita app = Cita.fromJson(data, _colorCollection[color.nextInt(9)]);
        setState(() {
          int index = events!.appointments!
              .indexWhere((app) => app.key == element.doc.id);

          Cita citaId = events!.appointments![index];

          events!.appointments!.remove(citaId);
          events!.notifyListeners(CalendarDataSourceAction.remove, [citaId]);
          events!.appointments!.add(app);
          events!.notifyListeners(CalendarDataSourceAction.add, [app]);
        });
      });
    });
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isInitialLoaded = true;
    return SafeArea(
      child: Scaffold(
          body: Consumer(
            builder: (_, w, __) {
              return SfCalendar(
                timeZone: 'SA Pacific Standard Time',
                controller: _calendarController,
                view: CalendarView.month,
                showDatePickerButton: true,
                onTap: (detalles) {},
                dataSource: events,
                monthViewSettings: const MonthViewSettings(
                  showAgenda: true,
                ),
              );
            },
          ),
          floatingActionButton: const BotonAgregarCita()),
    );
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

  Future<void> getDataFromFireStore() async {
    final snapShotsValue =
        await fireStoreReference.collection("citas_calendario_1").get();

    final Random random = new Random();
    List<Cita> list = snapShotsValue.docs
        .map((e) => Cita(
              eventName: e.data()['description'],
              from: e.data()['from'].toDate(),
              to: e.data()['to'].toDate(),
              background: _colorCollection[random.nextInt(9)],
              isAllDay: e.data()['isAllDay'],
            ))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
    });
  }
}
