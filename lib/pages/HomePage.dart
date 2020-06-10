import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefasdiarasapp/components/MainDrawerComponent.dart';
import 'package:tarefasdiarasapp/models/Tarefa.dart';
import 'package:tarefasdiarasapp/stores/Tarefa.dart';
import 'package:tarefasdiarasapp/stores/Usuario.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TarefaStore tarefaStore = Modular.get<TarefaStore>();
  UsuarioStore user = Modular.get<UsuarioStore>();

  @override
  void initState() {
    super.initState();
  }

  Future<List<Tarefa>> findAll(bool reflesh) async {
    var usuario = await user.getGoogleSignIn().signInSilently();
    return reflesh || tarefaStore.tarefas.length == 0
        ? tarefaStore.findAllByUserKey(usuario.id)
        : tarefaStore.tarefas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawerComponent(),
      appBar: AppBar(
        title: Text('Minhas Tarefas'),
        actions: <Widget>[
          IconButton(
            onPressed: () => this.findAll(true),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          new Flexible(
            child: FutureBuilder(
              initialData: [],
              future: findAll(false),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return renderList();
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 17),
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/edit-tarefa').then((v) {
          setState(() {
            this.findAll(true);
          });
        }),
        tooltip: 'Adicionar Tarefa',
        child: Icon(Icons.add),
      ),
    );
  }

  void swapTarefas(int oldIndex, int newIndex) async {
    int tam = this.tarefaStore.tarefas.length;
    newIndex = newIndex >= tam ? tam - 1 : newIndex;
    Tarefa oldIndexTarefa = this.tarefaStore.tarefas[oldIndex];
    Tarefa newIndexTarefa = this.tarefaStore.tarefas[newIndex];
    oldIndexTarefa.order = newIndex;
    newIndexTarefa.order = oldIndex;
    setState(() {
      this.tarefaStore.tarefas[newIndex] = oldIndexTarefa;
      this.tarefaStore.tarefas[oldIndex] = newIndexTarefa;
    });
    await this.tarefaStore.save(oldIndexTarefa);
    await this.tarefaStore.save(newIndexTarefa);
  }

  Widget renderList() {
    return Observer(
        builder: (_) => ReorderableListView(
              onReorder: (int oldIndex, int newIndex) {
                this.swapTarefas(oldIndex, newIndex);
              },
              children: <Widget>[
                // ignore: experiment_not_enabled
                for (int i = 0; i < tarefaStore.tarefas.length; i++)
                  Dismissible(
                    key: ValueKey(tarefaStore.tarefas[i].key),
                    background: Container(
                      child: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                    onDismissed: (v) {
                      tarefaStore.delete(tarefaStore.tarefas[i]).then((v) {
                        setState(() {
                          tarefaStore.tarefas.removeAt(i);
                        });
                      });
                    },
                    child: new ListTile(
                      title: tarefaStore.tarefas[i].nome == null
                          ? new Text("")
                          : new Text(tarefaStore.tarefas[i].nome),
                      subtitle: tarefaStore.tarefas[i].timeOfDay == null
                          ? new Text("")
                          : new Text(
                              tarefaStore.tarefas[i].timeOfDay.hour.toString() +
                                  ":" +
                                  tarefaStore.tarefas[i].timeOfDay.minute
                                      .toString()),
                      onTap: () => Navigator.pushNamed(context,
                              '/edit-tarefa/' + tarefaStore.tarefas[i].key)
                          .then((v) {
                        setState(() {
                          this.findAll(false);
                        });
                      }),
                      trailing: IconButton(
                        icon: Icon(
                            tarefaStore.tarefas[i].done
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: tarefaStore.tarefas[i].done
                                ? Colors.green
                                : null),
                        onPressed: () async {
                          Tarefa t = await this
                              .tarefaStore
                              .toggleDone(tarefaStore.tarefas[i].key);
                          setState(() {
                            tarefaStore.tarefas[i] = t;
                          });
                        },
                      ),
                    ),
                  ),
              ],
            ));
  }
}
