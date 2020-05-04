// flutter packages pub run build_runner build --delete-conflicting-outputs
import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tarefasdiarasapp/models/Tarefa.dart';

// Include generated file
part 'Tarefa.g.dart';

// This is the class used by rest of your codebase
class TarefaStore = TarefaBase with _$TarefaStore;

// The store-class

abstract class TarefaBase with Store {
  final databaseReference = Firestore.instance;

  final collection = "tarefas";

  @observable
  List<Tarefa> tarefas = [];

  @action
  Future<void> save(Tarefa tarefa) {
    if (tarefa.key == null) {
      return this.insert(tarefa);
    } else {
      return this.update(tarefa);
    }
  }

  Future<void> insert(Tarefa tarefa) {
    tarefa.createAt = DateTime.now();
    tarefa.done = false;
    return databaseReference
        .collection(collection)
        .document()
        .setData(tarefa.toJson());
  }

  Future<void> update(Tarefa tarefa) {
    tarefa.createAt = DateTime.now();
    return databaseReference
        .collection(collection)
        .document(tarefa.key)
        .setData(tarefa.toJson());
  }

  Future<List<Tarefa>> findAll() async {
    this.tarefas = [];
    var response =
        await databaseReference.collection(collection).getDocuments();
    this.tarefas = response.documents.map((f) {
      Tarefa t = Tarefa.fromJson(f.data);
      t.key = f.documentID;
      return t;
    }).toList();
    return this.tarefas;
  }

  Future<Tarefa> findOne(String key) async {
    var response =
        await databaseReference.collection(collection).document(key).get();
    Tarefa tarefa = Tarefa.fromJson(response.data);
    tarefa.key = response.documentID;
    return tarefa;
  }

  Future<Tarefa> toggleDone(String key) async {
    var tarefa = await this.findOne(key);
    tarefa.done = !tarefa.done;
    this.save(tarefa);
    return tarefa;
  }
}