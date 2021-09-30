import 'dart:convert';

import 'package:offside_yopal/app/ui/pages/calendar/model/Cita.dart';
import 'package:http/http.dart' as http;

class AddCitaController {
  final _url = 'offside-yopal-default-rtdb.firebaseio.com';

  Future<bool> addCita(Cita cita) async {
    final url = Uri.https(_url, 'CalendarData.json');
    final repose = await http.post(url, body: citaToJson(cita));
    final decoDate = jsonDecode(repose.body);
    return true;
  }

  Future<List<Cita>> cargarCitas() async {
    final url = Uri.https(_url, 'CalendarData.json');
    final List<Cita> citas = [];
    final response = await http.get(url);
    final Map<String, dynamic> decode = jsonDecode(response.body);
    decode.forEach((key, value) {
      final cita = Cita.fromJson(value);
      cita.user = key;
      citas.add(cita);
    });
    return citas;
  }
}
