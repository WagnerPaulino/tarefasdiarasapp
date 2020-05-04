import 'dart:convert';

Tarefa tarefaFromJson(String str) => Tarefa.fromJson(json.decode(str));

String tarefaToJson(Tarefa data) => json.encode(data.toJson());

class Tarefa {
  String key;
  String nome;
  DateTime createAt;
  DateTime timeOfDay;
  bool done;

  Tarefa({this.key, this.nome, this.createAt, this.timeOfDay, this.done});

  factory Tarefa.fromJson(Map<String, dynamic> json) => Tarefa(
      key: json["key"],
      nome: json["nome"],
      createAt: json["createAt"].toDate(),
      timeOfDay: json["timeOfDay"].toDate(),
      done: json["done"]);

  Map<String, dynamic> toJson() => {
        "key": key,
        "nome": nome,
        "createAt": createAt,
        "timeOfDay": timeOfDay,
        "done": done,
      };
}
