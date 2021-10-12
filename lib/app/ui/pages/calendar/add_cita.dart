import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:offside_yopal/app/ui/pages/calendar/controller/add_controller.dart';
import 'widget/modal_fechas.dart';
import 'model/Cita.dart';

class AddCita extends StatefulWidget {
  final Cita? cita;

  const AddCita({
    Key? key,
    this.cita,
  }) : super(key: key);

  @override
  State<AddCita> createState() => _AddCitaState();
}

class _AddCitaState extends State<AddCita> {
  late DateTime desde;
  final _keyFrom = GlobalKey<FormState>();
  final _textControl = TextEditingController();
  final citaProvider = AddCitaController();
  final cita = Cita();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting('es_ES', null);
    /* final citas = citaProvider.cargarCitas(); */
    if (widget.cita == null) {
      desde = DateTime.now();
    }
  }

  @override
  void dispose() {
    _textControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _customAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Form(
              key: _keyFrom,
              child: Column(
                children: <Widget>[
                  _inputCita(),
                  const SizedBox(height: 10),
                  /* TimePicker(desde, hasta), */
                  ModalFechas(desde),
                ],
              )),
        ),
      ),
    );
  }

  /* metodos widgeth */
  /* appbar custom */
  _customAppBar() {
    return AppBar(
      backgroundColor: Color(0xff2176a3),
      leading: const CloseButton(),
      actions: <Widget>[
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: saveForm,
          icon: const Icon(Icons.done),
          label: const Text(
            'Save',
          ),
        )
      ],
    );
  }

  /* nombre cita */
  Widget _inputCita() {
    return TextFormField(
      controller: _textControl,
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
          suffixIcon: const Icon(Icons.emoji_events_outlined),
          icon: const Icon(Icons.sports_soccer_rounded),
          labelText: 'Evento',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      onChanged: (val) {},
      onFieldSubmitted: (_) => saveForm(),
      validator: (nomCita) {
        (nomCita != null && nomCita.isEmpty)
            ? 'Este Campo no puede estar vacio'
            : null;
      },
    );
  }

  Future saveForm() async {
    final isValid = _keyFrom.currentState!.validate();
    final controllerFecha = fechaProvider.read.fechaFrom;
    // TODO: ver si existe
    final from = controllerFecha;
    final to = controllerFecha.add(const Duration(hours: 1));
    final collection =
        FirebaseFirestore.instance.collection('citas_calendario_1');
    if (isValid) {
      cita.resourceId = "correo@correo";
      cita.from = from;
      cita.to = to;
      cita.description = 'holii';
      cita.isAllDay = false;
      cita.eventName = _textControl.text;
      citaProvider.addDocument(collection, cita);
    }
    Navigator.pop(context);
  }
}
