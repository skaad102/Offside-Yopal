import 'package:flutter_meedu/flutter_meedu.dart';

class FechaController extends SimpleNotifier {
  DateTime _fecha = DateTime.now();
  late DateTime _subirFecha;

  DateTime get fecha => _fecha;
  DateTime get fechaFrom => _subirFecha;

  void selFecha(DateTime fecha) {
    _fecha = fecha;
    _subirFecha = fecha;
    notify();
  }
}
