import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefasdiarasapp/components/MainDrawerComponent.dart';
import 'package:tarefasdiarasapp/components/ToolBarComponent.dart';
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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    this.findAll();
    super.initState();
  }

  Future<void> findAll() {
    return user.getGoogleSignIn().signInSilently().then((user) {
      tarefaStore.findAllByUserKey(user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawerComponent(),
      body: CustomScrollView(
        physics: ScrollPhysics(),
        slivers: <Widget>[
          ToolBarComponent("Minhas Tarefas"),
          SliverFillRemaining(
              child: Column(
            children: <Widget>[
              new Flexible(
                  child: Observer(
                builder: (_) => RefreshIndicator(
                    onRefresh: () => this.findAll(),
                    child: ListView.builder(
                      itemBuilder: (c, i) {
                        return Column(
                          children: <Widget>[
                            Dismissible(
                              key: ValueKey(tarefaStore.tarefas[i].key),
                              background: Container(
                                child: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                              onDismissed: (v) {
                                tarefaStore
                                    .delete(tarefaStore.tarefas[i])
                                    .then((v) {
                                  setState(() {
                                    tarefaStore.tarefas.removeAt(i);
                                  });
                                });
                              },
                              child: new ListTile(
                                title: tarefaStore.tarefas[i].nome == null
                                    ? new Text("")
                                    : new Text(tarefaStore.tarefas[i].nome),
                                subtitle: tarefaStore.tarefas[i].timeOfDay ==
                                        null
                                    ? new Text("")
                                    : new Text(tarefaStore
                                            .tarefas[i].timeOfDay.hour
                                            .toString() +
                                        ":" +
                                        tarefaStore.tarefas[i].timeOfDay.minute
                                            .toString()),
                                onTap: () => Navigator.pushNamed(
                                        context,
                                        '/edit-tarefa/' +
                                            tarefaStore.tarefas[i].key)
                                    .then((v) {
                                  setState(() {
                                    this.findAll();
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
                                  onPressed: () {
                                    this
                                        .tarefaStore
                                        .toggleDone(tarefaStore.tarefas[i].key)
                                        .then((tarefa) {
                                      setState(() {
                                        tarefaStore.tarefas[i].done =
                                            !tarefaStore.tarefas[i].done;
                                      });
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: tarefaStore.tarefas.length,
                    )),
              ))
            ],
          ))
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
            this.findAll();
          });
        }),
        tooltip: 'Adicionar Tarefa',
        child: Icon(Icons.add),
      ),
    );
  }
}
