import 'package:flutter/animation.dart';

class TodoModel {
  // color, , description, and date
  final int? id;
  final String? status;
  final String? color;
  final String? description;
  final String? date;

  TodoModel({this.id, this.status, this.color, this.description, this.date});

  TodoModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        status = res['status'],
        color = res['color'],
        description = res['description'],
        date = res['date'];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "status": status,
      "color": color,
      "description": description,
      "date": date
    };
  }
}
