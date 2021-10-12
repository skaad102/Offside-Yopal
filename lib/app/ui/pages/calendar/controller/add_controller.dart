import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:offside_yopal/app/ui/pages/calendar/model/Cita.dart';

import 'event_data_source.dart';

final citaProvider = SimpleProvider(
  (_) => AddCitaController(),
);

class AddCitaController extends SimpleNotifier {
  final _url = 'offside-yopal-default-rtdb.firebaseio.com';

  MeetingDataSource? _events;

  MeetingDataSource? get events => _events;

  ///añadir datos con firestre
  /* FireStore implementado */
  Future<DocumentReference> addDocument(
      CollectionReference collection, Cita cita) async {
    return await collection.add(cita.toJson());
  }

  ///traer los dats de fistore
  /* Future<void> fetchAllCitas(CollectionReference collection) async {
    final snapShotsValue = await collection.get();

    List<Cita> citas = snapShotsValue.docs
        .map((e) => Cita(
              eventName: e.data()['description'],
              from: e.data()['from'].toDate(),
              to: e.data()['to'].toDate(),
              background: const Color(0x7F7FF3FF),
              isAllDay: e.data()['isAllDay'],
            ))
        .toList();
    _events = MeetingDataSource(citas);
    notify();
  } */
}
