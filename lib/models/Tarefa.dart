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
  bool done;
  User user;

  Tarefa(
      {this.key,
      this.nome,
      this.createdAt,
      this.updatedAt,
      this.timeOfDay,
      this.done});

  factory Tarefa.fromJson(Map<String, dynamic> json) => Tarefa(
      key: json["key"],
      nome: json["nome"],
      createdAt: json["createAt"].toDate(),
      timeOfDay: json["timeOfDay"] != null ? json["timeOfDay"].toDate() : null,
      done: json["done"]);

  Map<String, dynamic> toJson() => {
        "key": key,
        "nome": nome,
        "createAt": createdAt,
        "updatedAt": updatedAt,
        "timeOfDay": timeOfDay,
        "done": done,
        "user": this.user.toJson()
      };
}
