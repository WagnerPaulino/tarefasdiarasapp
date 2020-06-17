import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefasdiarasapp/components/ListTarefas.dart';
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
    this.findAll();
  }

  Future<List<Tarefa>> findAll() async {
    var usuario = await user.getGoogleSignIn().signInSilently();
    return tarefaStore.findAllByUserKey(usuario.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawerComponent(),
      appBar: AppBar(
        title: Text('Minhas Tarefas'),
        actions: <Widget>[
//          FlatButton(
//            onPressed: () {},
//            child: Row(
//              mainAxisSize: MainAxisSize.max,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text(
//                  "Novo ",
//                  style: TextStyle(color: Colors.white),
//                ),
//                Icon(
//                  Icons.add,
//                  color: Colors.white,
//                )
//              ],
//            ),
//          )
//          IconButton(
//            onPressed: () => this.findAll(true),
//            icon: Icon(Icons.refresh),
//          )
        ],
      ),
      body: Column(
        children: <Widget>[
          new Flexible(
            child: Observer(
              builder: (_) => tarefaStore.isLoadingList
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListTarefasComponent(
                      tarefas: tarefaStore.tarefas,
                    ),
            ),
          ),
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
