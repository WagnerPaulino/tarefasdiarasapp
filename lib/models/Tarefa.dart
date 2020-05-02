// flutter packages pub run build_runner build --delete-conflicting-outputs
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'Tarefa.g.dart';

// This is the class used by rest of your codebase
class TarefaStore = TarefaBase with _$TarefaStore;

// The store-class

abstract class TarefaBase with Store {
  @observable
  List<Tarefa> tarefas = [];

  @action
  void save(Tarefa tarefa) {
    tarefas.add(tarefa);
  }
}

class Tarefa {
  String key;
  String nome;
  DateTime createAt;
  DateTime timeOfDay;
}