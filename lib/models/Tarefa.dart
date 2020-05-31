import 'dart:convert';

import 'User.dart';

Tarefa tarefaFromJson(String str) => Tarefa.fromJson(json.decode(str));

String tarefaToJson(Tarefa data) => json.encode(data.toJson());

class Tarefa {
  String key;
  String nome;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime timeOfDay;
  DateTime doneUpdated;
  bool done;
  User user;

  Tarefa(
      {this.key,
      this.nome,
      this.createdAt,
      this.updatedAt,
      this.timeOfDay,
      this.done,
      this.doneUpdated,
      this.user});

  factory Tarefa.fromJson(Map<String, dynamic> json) => Tarefa(
      key: json["key"],
      nome: json["nome"],
      createdAt: json["createAt"].toDate(),
      timeOfDay: json["timeOfDay"] != null ? json["timeOfDay"].toDate() : null,
      done: json["done"],
      doneUpdated:
          json["doneUpdated"] != null ? json["doneUpdated"].toDate() : null,
      user: User.fromJson(json["user"]));

  Map<String, dynamic> toJson() => {
        "key": key,
        "nome": nome,
        "createAt": createdAt,
        "updatedAt": updatedAt,
        "timeOfDay": timeOfDay,
        "done": done,
        "doneUpdated": doneUpdated,
        "user": this.user.toJson()
      };
}
