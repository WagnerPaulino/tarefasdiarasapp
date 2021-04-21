// flutter packages pub run build_runner build --delete-conflicting-outputs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:tarefasdiarasapp/config/NotificationConfig.dart';

import 'package:tarefasdiarasapp/models/Tarefa.dart';
import 'package:tarefasdiarasapp/models/Usuario.dart';

import 'Usuario.dart';

// Include generated file
part 'Tarefa.g.dart';

// This is the class used by rest of your codebase
class TarefaStore = TarefaBase with _$TarefaStore;

// The store-class

abstract class TarefaBase with Store {
  final databaseReference = FirebaseFirestore.instance;

  final UsuarioStore user = new UsuarioStore();

  final NotificationConfig notificationConfig = new NotificationConfig();

  final collection = "tarefas";

  @observable
  List<Tarefa> tarefas = [];

  @observable
  bool isLoadingList = false;

  @observable
  bool isSaving = false;

  @action
  Future save(Tarefa tarefa) {
    this.isSaving = true;
    return user.getGoogleSignIn().signInSilently().then((v) async {
      if (v != null) {
        tarefa.user = Usuario(v);
        if (tarefa.key == null) {
          await this.insert(tarefa);
        } else {
          await this.update(tarefa);
        }
      }
    }).then((value) {
      this.notificationConfig.agendarNotificacoesTarefas(tarefas);
      this.isSaving = false;
    });
  }

  Future<void> insert(Tarefa tarefa) {
    tarefa.createdAt = DateTime.now();
    tarefa.doneUpdated = DateTime.now();
    tarefa.done = false;
    tarefa.order = tarefas.length;
    return databaseReference
        .collection(collection)
        .doc()
        .set(tarefa.toJson())
        .then((value) {
    });
  }

  Future<void> update(Tarefa tarefa) {
    tarefa.updatedAt = DateTime.now();
    return databaseReference
        .collection(collection)
        .doc(tarefa.key)
        .set(tarefa.toJson())
        .then((value) {
    });
  }

  Future<void> delete(Tarefa tarefa) async {
    await databaseReference
        .collection(collection)
        .doc(tarefa.key)
        .delete();
    this.notificationConfig.agendarNotificacoesTarefas(tarefas);
  }

  Future<List<Tarefa>> findAll() async {
    isLoadingList = true;
    this.tarefas = [];
    var response =
        await databaseReference.collection(collection).get();
    this.tarefas = response.docs.map((f) {
      Tarefa t = Tarefa.fromJson(f.data());
      t.key = f.id;
      return t;
    }).toList();
    isLoadingList = false;
    return this.tarefas;
  }

  Future<List<Tarefa>> findAllByUserKey(String userKey) async {
    isLoadingList = true;
    this.tarefas = [];
    var response = await databaseReference
        .collection(collection)
        .where("user.id", isEqualTo: userKey)
        .orderBy("order")
        .get();
    this.tarefas = response.docs.map((f) {
      Tarefa t = Tarefa.fromJson(f.data());
      t.key = f.id;
      return t;
    }).toList();
    await this.updateDoneFromList(tarefas);
    isLoadingList = false;
    this.notificationConfig.agendarNotificacoesTarefas(tarefas);
    return this.tarefas;
  }

  Future<Tarefa> findOne(String key) async {
    var response =
        await databaseReference.collection(collection).doc(key).get();
    Tarefa tarefa = Tarefa.fromJson(response.data());
    tarefa.key = response.id;
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
        .doc(tarefa.key)
        .set(tarefa.toJson());
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

  void reorderList(List<Tarefa> tas) async {
    for (int i = 0; i < tas.length; i++) {
      print(tas[i].nome + tas[i].order.toString());
      if (tas[i].order != i) {
        tas[i].order = i;
        print("Atualizado: " + tas[i].nome + tas[i].order.toString());
        await this.update(tas[i]);
      }
    }
  }
}
