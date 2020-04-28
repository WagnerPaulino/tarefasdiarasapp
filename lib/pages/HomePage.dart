import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tarefasdiarasapp/components/DialogTarefa.dart';
import 'package:tarefasdiarasapp/models/Tarefa.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TarefaStore tarefaStore = new TarefaStore();

  void navToSaveTarefa() {
    _showDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
              padding: EdgeInsets.only(top: 40, right: 15, left: 15),
              sliver: SliverAppBar(
                floating: true,
                expandedHeight: 10,
                leading: Container(
                  height: 0,
                  width: 0,
                ),
                primary: false,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    side: BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        style: BorderStyle.solid)),
                actions: <Widget>[
                  Text(
                    "Minhas Tarefas",
                    style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
                backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              )),
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
        onPressed: () => this.navToSaveTarefa(),
        tooltip: 'Adicionar Tarefa',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogTarefa();
      },
    );
  }
}
