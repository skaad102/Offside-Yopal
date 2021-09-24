/* import 'package:flutter/material.dart';

class Cita {
  const Cita(
      {this.userId,
      this.eventName,
      this.from,
      this.to,
      this.background = Colors.red,
      this.isAllDay = false,
      this.description});

  final String? userId;
  final String? eventName;
  final DateTime? from;
  final Color? background;
  final DateTime? to;
  final bool? isAllDay;
  final String? description;
}


 */

// To parse this JSON data, do
//
//     final cita = citaFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/cupertino.dart';

Cita citaFromJson(String str) => Cita.fromJson(json.decode(str));

String citaToJson(Cita data) => json.encode(data.toJson());

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
  DateTime? from;
  DateTime? to;
  bool? diario;
  Color? background;
  String? description;

  factory Cita.fromJson(Map<String, dynamic> json) => Cita(
        user: json["user"],
        event: json["event"],
        from: json["from"],
        to: json["to"],
        diario: json["diario"],
        background: json["background"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "event": event,
        "from": from,
        "to": to,
        "diario": diario,
        "background": background,
        "description": description,
      };
}
