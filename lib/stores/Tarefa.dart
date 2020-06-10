// flutter packages pub run build_runner build --delete-conflicting-outputs
import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tarefasdiarasapp/models/Tarefa.dart';
import 'package:tarefasdiarasapp/models/User.dart';

import 'Usuario.dart';

// Include generated file
part 'Tarefa.g.dart';

// This is the class used by rest of your codebase
class TarefaStore = TarefaBase with _$TarefaStore;

// The store-class

abstract class TarefaBase with Store {
  final databaseReference = Firestore.instance;

  final UsuarioStore user = new UsuarioStore();

  final collection = "tarefas";

  @observable
  List<Tarefa> tarefas = [];

  @action
  Future save(Tarefa tarefa) {
    return user.getGoogleSignIn().signInSilently().then((v) {
      if (v != null) {
        tarefa.user = User(v);
        if (tarefa.key == null) {
          return this.insert(tarefa);
        } else {
          return this.update(tarefa);
        }
      } else {
        return Future(() => false);
      }
    });
  }

  Future<void> insert(Tarefa tarefa) {
    tarefa.createdAt = DateTime.now();
    tarefa.doneUpdated = DateTime.now();
    tarefa.done = false;
    return databaseReference
        .collection(collection)
        .document()
        .setData(tarefa.toJson());
  }

  Future<void> update(Tarefa tarefa) {
    tarefa.updatedAt = DateTime.now();
    return databaseReference
        .collection(collection)
        .document(tarefa.key)
        .setData(tarefa.toJson());
  }

  Future<void> delete(Tarefa tarefa) {
    return databaseReference
        .collection(collection)
        .document(tarefa.key)
        .delete();
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

  Future<List<Tarefa>> findAllByUserKey(String userKey) async {
    this.tarefas = [];
    var response = await databaseReference
        .collection(collection)
        .where("user.id", isEqualTo: userKey)
        .orderBy("order")
        .getDocuments();
    this.tarefas = response.documents.map((f) {
      Tarefa t = Tarefa.fromJson(f.data);
      t.key = f.documentID;
      return t;
    }).toList();
    await this.updateDoneFromList(tarefas);
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
    tarefa.doneUpdated = DateTime.now();
    tarefa.done = !tarefa.done;
    this.save(tarefa);
    return tarefa;
  }

  Future<void> onlyUpdate(Tarefa tarefa) async {
    await databaseReference
        .collection(collection)
        .document(tarefa.key)
        .setData(tarefa.toJson());
  }

  Future<void> updateDone(String idUser) async {
    var v = await user.getGoogleSignIn().signInSilently();
    List<Tarefa> tarefas = await this.findAllByUserKey(v.id);
    filterTarefaForUpdated(tarefas).forEach((t) async {
      t.done = false;
      t.doneUpdated = DateTime.now();
      await this.onlyUpdate(t);
    });
  }

  Future<void> updateDoneFromList(List<Tarefa> tarefas) async {
    if (tarefas != null) {
      filterTarefaForUpdated(tarefas).forEach((t) {
        t.done = false;
        t.doneUpdated = DateTime.now();
        this.onlyUpdate(t);
      });
    }
  }

  List<Tarefa> filterTarefaForUpdated(List<Tarefa> tarefas) {
    return tarefas
        .where((t) => DateTime(
                t.doneUpdated.year, t.doneUpdated.month, t.doneUpdated.day)
            .isBefore(DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)))
        .toList();
  }
}
