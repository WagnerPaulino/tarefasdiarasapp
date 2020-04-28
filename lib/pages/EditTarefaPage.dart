import 'package:flutter/material.dart';
import 'package:tarefasdiarasapp/components/ToolBarComponent.dart';
import 'package:tarefasdiarasapp/models/Tarefa.dart';

class EditTarefaPage extends StatefulWidget {
  EditTarefaPage({Key key}) : super(key: key);

  @override
  _EditTarefaPageState createState() => _EditTarefaPageState();
}

class _EditTarefaPageState extends State<EditTarefaPage> {
  TarefaStore tarefaStore = new TarefaStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          ToolBarComponent("Tarefas"),
          SliverFillRemaining(
              child: Column(
            children: <Widget>[
              Text('You will never be satisfied.'),
              Text('You\’re like me. I’m never satisfied.'),
              RaisedButton(
                child: Text('Marcar hora'),
                onPressed: () async {
                  final datePicker = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  print(datePicker);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new FlatButton(
                    child: new Text("Fechar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new RaisedButton(
                    child: new Text("Salvar"),
                    color: Colors.blueAccent,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
