// flutter packages pub run build_runner build --delete-conflicting-outputs
import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:tarefasdiarasapp/models/Tarefa.dart';

// Include generated file
part 'Tarefa.g.dart';

// This is the class used by rest of your codebase
class TarefaStore = TarefaBase with _$TarefaStore;

// The store-class

abstract class TarefaBase with Store {
  final databaseReference = Firestore.instance;

  @observable
  List<Tarefa> tarefas = [];

  @action
  void save(Tarefa tarefa) {
    tarefa.createAt = DateTime.now();
    databaseReference.collection("tarefas").document().setData(tarefa.toJson());
  }

  Future<List<Tarefa>> findAll() async {
    tarefas = [];
    var response = await databaseReference.collection("tarefas").getDocuments();
    tarefas = response.documents.map((f) => Tarefa.fromJson(f.data)).toList();
    return tarefas;
  }
}
