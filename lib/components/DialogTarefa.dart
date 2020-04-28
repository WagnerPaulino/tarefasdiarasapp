import 'package:flutter/material.dart';

class DialogTarefa extends StatelessWidget {

  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Tarefa"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('You will never be satisfied.'),
            Text('You\’re like me. I’m never satisfied.'),
          ],
        ),
      ),
      actions: <Widget>[
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
    );
  }

}