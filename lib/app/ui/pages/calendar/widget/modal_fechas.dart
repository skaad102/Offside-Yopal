import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:intl/intl.dart';
import '../controller/fecha_controller.dart';

final fechaProvider = SimpleProvider(
  (_) => FechaController(),
);

class ModalFechas extends StatefulWidget {
  final DateTime desde;
  const ModalFechas(this.desde, {Key? key}) : super(key: key);

  @override
  _ModalFechasState createState() => _ModalFechasState();
}

class _ModalFechasState extends State<ModalFechas> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _rowInputs(header: 'Dede la fecha:', child: _inputFecha(widget.desde)),
        /* _selHasta() */
      ],
    );
  }

  Widget _rowInputs({required String header, child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        child,
      ],
    );
  }

  Widget _inputFecha(date) => Row(
        children: [
          /* los 4 inputs de fechas */
          Consumer(
            builder: (_, watch, __) {
              final controller = watch(fechaProvider);
              return Expanded(
                flex: 2,
                child: _selFecha(
                    text: DateFormat.yMMMEd('es_CO').format(controller.fecha),
                    onClicked: () => _abrirCalendeario(
                          pickDate: true,
                          date: controller.fecha,
                        )),
              );
            },
          ),
          Consumer(builder: (_, watch, __) {
            final controller = watch(fechaProvider);
            return Expanded(
              child: _selFecha(
                  text: DateFormat.Hm().format(controller.fecha),
                  onClicked: () => _abrirCalendeario(
                        pickDate: false,
                        date: controller.fecha,
                      )),
            );
          }),
        ],
      );

  _selFecha({required String text, required VoidCallback onClicked}) {
    return ListTile(
      title: Text(text),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: onClicked,
    );
  }

  Future _abrirCalendeario({
    required bool pickDate,
    required DateTime date,
  }) async {
    final fecha = await pickDateTime(date,
        pickDate: pickDate, fistDate: pickDate ? widget.desde : null);
    if (fecha == null) return null;
    fechaProvider.read.selFecha(fecha);
  }

  /* esperar a que el usuario coloque la fecha del calendario */
  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required bool pickDate, DateTime? fistDate}) async {
    if (pickDate) {
      final fechaSel = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: fistDate ?? DateTime(2019, 1),
        lastDate: DateTime(2100),
      );
      if (fechaSel == null) return null;

      final hora = Duration(hours: initialDate.hour, minutes: initialDate.hour);

      return fechaSel.add(hora);
    } else {
      final horaDia = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (horaDia == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);

      if (horaDia.minute < 30) {
        Duration hora = Duration(hours: horaDia.hour, minutes: 00);
        return date.add(hora);
      }
      Duration hora = Duration(hours: horaDia.hour, minutes: 00);
      return date.add(hora);
    }
  }
}
