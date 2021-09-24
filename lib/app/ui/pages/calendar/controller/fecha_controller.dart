import 'package:flutter_meedu/flutter_meedu.dart';

class FechaController extends SimpleNotifier {
  DateTime _fecha = DateTime.now();

  DateTime get fecha => _fecha;

  void selFecha(DateTime fecha) {
    _fecha = fecha;
    notify();
  }
}
