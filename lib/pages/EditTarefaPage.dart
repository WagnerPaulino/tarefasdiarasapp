import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:tarefasdiarasapp/models/Tarefa.dart';
import 'package:tarefasdiarasapp/stores/Tarefa.dart';
import 'package:date_format/date_format.dart';
//import 'dart:async';
//import 'package:path/path.dart' show join;

class EditTarefaPage extends StatefulWidget {
  EditTarefaPage({Key? key, this.tarefaKey}) : super(key: key);

  final String? tarefaKey;

  @override
  _EditTarefaPageState createState() => _EditTarefaPageState();
}

class _EditTarefaPageState extends State<EditTarefaPage> {
  Tarefa tarefa = new Tarefa();
  TarefaStore tarefaStore = Modular.get<TarefaStore>();
  final _formKey = GlobalKey<FormState>();
  final nomeFieldCtl = TextEditingController();
  final detalheFieldCtl = TextEditingController();

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
          this.nomeFieldCtl.text = this.tarefa.nome!;
          if (this.tarefa.detalhe == null) {
            return;
          }
          this.detalheFieldCtl.text = this.tarefa.detalhe!;
        });
      });
    }
  }

  Future<void> showDataPickerTimeOfDay() async {
    final t = await showTimePicker(
        context: context,
        initialTime: tarefa.timeOfDay == null
            ? TimeOfDay.now()
            : TimeOfDay.fromDateTime(tarefa.timeOfDay!));
    if (t?.hour != null && t?.minute != null) {
      setState(() {
        final now = new DateTime.now();
        tarefa.timeOfDay =
            new DateTime(now.year, now.month, now.day, t!.hour, t.minute);
      });
    }
  }

  Widget getHour() {
    return Row(
      children: [
        Text("Horario: ", style: TextStyle(color: Colors.black)),
        Text(formatDate(tarefa.timeOfDay!, [HH, ':', nn]))
      ],
    );
  }

  Widget getTextFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(labelText: 'Nome da Tarefa'),
          onChanged: (value) {
            tarefa.nome = value;
          },
          validator: (v) {
            if (v!.isEmpty) {
              return "O Nome da Tarefa é Obrigatório";
            } else {
              return null;
            }
          },
          controller: nomeFieldCtl,
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Deseja adicionar algum detalhe?'),
          onChanged: (value) {
            tarefa.detalhe = value;
          },
          controller: detalheFieldCtl,
        ),
        TextButton(
          child: tarefa.timeOfDay == null
              ? Text(
                  'Deseja marcar um horário?',
                )
              : getHour(),
          onPressed: showDataPickerTimeOfDay,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Tarefas'),
        actions: <Widget>[
          Observer(
              builder: (_) => TextButton(
                  child: Text(
                    this.tarefaStore.isSaving ? "Salvando..." : "Salvar",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: this.tarefaStore.isSaving
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            await tarefaStore.save(tarefa);
                            Modular.to.navigate('/', replaceAll: true);
                          }
                        }))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: getTextFormFields(),
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
