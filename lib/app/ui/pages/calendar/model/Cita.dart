import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

Cita citaFromJson(String str) => Cita.fromJson(json.decode(str));

String citaToJson(Cita data) => jsonEncode(data.toJson());

class Cita {
  Cita({
    this.user,
    this.event,
    this.from,
    this.to,
    this.diario,
    this.background,
    this.description,
  });

  String? user;
  String? event;
  String? from;
  String? to;
  bool? diario;
  String? background;
  String? description;

  factory Cita.fromJson(Map<String, dynamic> json) => Cita(
        user: json["user"],
        event: json["event"],
        from: (json["from"]),
        to: (json["to"]),
        diario: json["diario"],
        background: json["background"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "event": event,
        "from": from.toString(),
        "to": to.toString(),
        "diario": diario,
        "background": background.toString(),
        "description": description,
      };
}
