import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tarefasdiarasapp/components/MainDrawerComponent.dart';
import 'package:tarefasdiarasapp/components/ToolBarComponent.dart';
import 'package:tarefasdiarasapp/models/Tarefa.dart';
import 'package:tarefasdiarasapp/stores/Tarefa.dart';
import 'dart:async';
import 'package:path/path.dart' show join;

class EditTarefaPage extends StatefulWidget {
  EditTarefaPage({Key key, this.tarefaKey, @required this.camera})
      : super(key: key);

  String tarefaKey;

  final CameraDescription camera;

  @override
  _EditTarefaPageState createState() => _EditTarefaPageState();
}

class _EditTarefaPageState extends State<EditTarefaPage> {
  Tarefa tarefa = new Tarefa();
  TarefaStore tarefaStore = TarefaStore();
  final _formKey = GlobalKey<FormState>();
  final nomeFieldCtl = TextEditingController();
  CameraController cameraController;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    processData();
    configCamera();
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
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

  configCamera() {
    cameraController = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawerComponent(),
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
                      Container(
                        height: 350,
                        child: FutureBuilder<void>(
                          initialData: Text("Não há fotos"),
                          future: _initializeControllerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return CameraPreview(cameraController);
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                      FlatButton(
                        child: Text("Tirar foto"),
                        onPressed: () async {
                          try {
                            await _initializeControllerFuture;
                            final path = join(
                              (await getTemporaryDirectory()).path,
                              '${DateTime.now()}.png',
                            );
                            await cameraController.takePicture(path);
                          } catch (e) {
                            print(e);
                          }
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
                              tarefaStore.save(tarefa).then((v) {
                                Navigator.of(context).pop(context);
                              });
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
