import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefasdiarasapp/models/Tarefa.dart';
import 'package:tarefasdiarasapp/stores/Tarefa.dart';
import 'package:date_format/date_format.dart';
import 'package:tarefasdiarasapp/stores/Usuario.dart';

class ListTarefasComponent extends StatefulWidget {
  ListTarefasComponent({Key? key, this.tarefas}) : super(key: key);

  final List<Tarefa>? tarefas;

  @override
  _ListTarefasComponentState createState() => _ListTarefasComponentState();
}

class _ListTarefasComponentState extends State<ListTarefasComponent> {
  TarefaStore tarefaStore = Modular.get<TarefaStore>();
  UsuarioStore user = Modular.get<UsuarioStore>();
  bool isLogged = false;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Tarefa>> findAll() async {
    var usuario = await user.getGoogleSignIn().signInSilently();
    if (usuario == null) {
      return await Future.any([]);
    } else {
      return await tarefaStore.findAllByUserKey(usuario.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {
        this.swapTarefas(oldIndex, newIndex);
      },
      children: <Widget>[
        // ignore: experiment_not_enabled
        for (int i = 0; i < this.widget.tarefas!.length; i++)
          Dismissible(
            key: ValueKey(this.widget.tarefas![i].key),
            background: Container(
              child: Icon(Icons.delete),
              color: Colors.red,
            ),
            onDismissed: (v) {
              tarefaStore.delete(this.widget.tarefas![i]).then((v) {
                setState(() {
                  this.widget.tarefas!.removeAt(i);
                });
              });
            },
            child: new ListTile(
              title: this.widget.tarefas![i].nome == null
                  ? new Text("")
                  : new Text(this.widget.tarefas![i].nome!),
              subtitle: this.widget.tarefas![i].timeOfDay == null
                  ? new Text("")
                  : new Text(formatDate(
                      this.widget.tarefas![i].timeOfDay!, [HH, ':', nn])),
              onTap: () {
                Modular.to
                    .pushNamed('/edit-tarefa/' + this.widget.tarefas![i].key!)
                    .then((value) => this.findAll());
              },
              trailing: IconButton(
                icon: Icon(
                    this.widget.tarefas![i].done!
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: this.widget.tarefas![i].done! ? Colors.green : null),
                onPressed: () async {
                  Tarefa t = await this
                      .tarefaStore
                      .toggleDone(this.widget.tarefas![i].key);
                  setState(() {
                    this.widget.tarefas![i] = t;
                  });
                },
              ),
            ),
          ),
      ],
    );
  }

  void swapTarefas(int oldIndex, int newIndex) async {
    Tarefa oldIndexTarefa = this.widget.tarefas![oldIndex];
    this.widget.tarefas!.removeAt(oldIndex);
    int tam = this.widget.tarefas!.length;
    setState(() {
      if (newIndex > tam) {
        this.widget.tarefas!.add(oldIndexTarefa);
      } else {
        this.widget.tarefas!.insert(newIndex, oldIndexTarefa);
      }
    });
    this.tarefaStore.reorderList(this.widget.tarefas!);
  }
}
