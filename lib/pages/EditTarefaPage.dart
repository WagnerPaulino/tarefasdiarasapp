import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:tarefasdiarasapp/models/Tarefa.dart';
import 'package:tarefasdiarasapp/stores/Tarefa.dart';
//import 'dart:async';
//import 'package:path/path.dart' show join;

class EditTarefaPage extends StatefulWidget {
  EditTarefaPage({Key key, this.tarefaKey, @required this.camera})
      : super(key: key);

  final String tarefaKey;

  final CameraDescription camera;

  @override
  _EditTarefaPageState createState() => _EditTarefaPageState();
}

class _EditTarefaPageState extends State<EditTarefaPage> {
  Tarefa tarefa = new Tarefa();
  TarefaStore tarefaStore = TarefaStore();
  final _formKey = GlobalKey<FormState>();
  final nomeFieldCtl = TextEditingController();

  @override
  void initState() {
    processData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  processData() {
    if (widget.tarefaKey == null) {
      tarefa = new Tarefa();
    } else {
      tarefaStore.findOne(widget.tarefaKey).then((tarefa) {
        setState(() {
          this.tarefa = tarefa;
          this.nomeFieldCtl.text = this.tarefa.nome;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Tarefas'),
        actions: <Widget>[
          FlatButton(
              child: Text(
                "Salvar",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  tarefaStore.save(tarefa).then((v) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  });
                }
              })
        ],
      ),
      body: Column(
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
                    validator: (v) {
                      if (v.isEmpty) {
                        return "O Nome da Tarefa é Obrigatório";
                      } else {
                        return null;
                      }
                    },
                    controller: nomeFieldCtl,
                  ),
                  FlatButton(
                    child: tarefa.timeOfDay == null
                        ? Text('Marcar hora')
                        : Text(tarefa.timeOfDay.hour.toString() +
                            ":" +
                            tarefa.timeOfDay.minute.toString()),
                    onPressed: () async {
                      final t = await showTimePicker(
                          context: context,
                          initialTime: tarefa.timeOfDay == null
                              ? TimeOfDay.now()
                              : TimeOfDay.fromDateTime(tarefa.timeOfDay));
                      setState(() {
                        final now = new DateTime.now();
                        tarefa.timeOfDay = new DateTime(
                            now.year, now.month, now.day, t.hour, t.minute);
                      });
                    },
                  ),
                ],
              )),
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
