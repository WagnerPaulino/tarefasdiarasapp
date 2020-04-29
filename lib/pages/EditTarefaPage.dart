import 'package:flutter/material.dart';
import 'package:tarefasdiarasapp/components/ToolBarComponent.dart';
import 'package:tarefasdiarasapp/models/Tarefa.dart';

class EditTarefaPage extends StatefulWidget {
  EditTarefaPage({Key key}) : super(key: key);

  @override
  _EditTarefaPageState createState() => _EditTarefaPageState();
}

class _EditTarefaPageState extends State<EditTarefaPage> {
  Tarefa tarefa = new Tarefa();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          ToolBarComponent("Tarefas"),
          SliverFillRemaining(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Nome da Tarefa'),
                        onChanged: (value) {
                          tarefa.nome = value;
                        },
                      ),
                    ],
                  )),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  child: tarefa.timeOfDay == null
                      ? Text('Marcar hora')
                      : Text(tarefa.timeOfDay.format(context)),
                  onPressed: () async {
                    final datePicker = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    setState(() {
                      tarefa.timeOfDay = datePicker;
                    });
                  },
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new FlatButton(
                            child: new Text("Cancelar"),
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
                      )
                    ],
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
