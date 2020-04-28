import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tarefasdiarasapp/components/ToolBarComponent.dart';
import 'package:tarefasdiarasapp/models/Tarefa.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TarefaStore tarefaStore = new TarefaStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          ToolBarComponent("Minhas Tarefas"),
          SliverFillRemaining(
              child: Column(
            children: <Widget>[],
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
            children: <Widget>[
              new Flexible(
                child: Observer(
                    builder: (_) => ListView.builder(
                          itemBuilder: (c, i) {
                            return Column(
                              children: <Widget>[
                                new ListTile(
                                  title: new Text(tarefaStore.tarefas[i].nome),
                                ),
                              ],
                            );
                          },
                          itemCount: tarefaStore.tarefas.length,
                        )),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/edit-tarefa'),
        tooltip: 'Adicionar Tarefa',
        child: Icon(Icons.add),
      ),
    );
  }
}
