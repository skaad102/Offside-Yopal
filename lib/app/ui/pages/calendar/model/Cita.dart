import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

Cita citaFromJson(String str, Color color) =>
    Cita.fromJson(json.decode(str), color);

String citaToJson(Cita data) => jsonEncode(data.toJson());

class Cita {
  Cita({
    this.resourceId,
    this.eventName,
    this.from,
    this.to,
    this.isAllDay,
    this.background,
    this.description,
  });

  String? resourceId;
  String? eventName;
  DateTime? from;
  DateTime? to;
  bool? isAllDay;
  Color? background;
  String? description;

  factory Cita.fromJson(Map<String, dynamic> json, Color color) => Cita(
        resourceId: json["resourceId"],
        eventName: json["eventName"],
        from: json["from"].toDate(),
        to: json["to"].toDate(),
        isAllDay: json["isAllDay"],
        background: color,
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "resourceId": resourceId,
        "eventName": eventName,
        "from": from,
        "to": to,
        "isAllDay": isAllDay,
        "description": description,
      };
}
