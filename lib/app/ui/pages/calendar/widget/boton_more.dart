import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';

class BotonAgregarCita extends StatelessWidget {
  const BotonAgregarCita({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.more_horiz,
      activeIcon: Icons.more,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.add_box_rounded),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          label: 'Añadir',
          onTap: () => Navigator.pushNamed(context, Routes.ADD_CITA),
        ),
        SpeedDialChild(
          child: const Icon(Icons.delete_rounded),
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          label: 'Eliminar',
          onTap: () => debugPrint('SECOND CHILD'),
        ),
      ],
    );
  }
}
