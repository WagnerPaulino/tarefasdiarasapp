import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tarefasdiarasapp/components/ToolBarComponent.dart';
import 'package:tarefasdiarasapp/stores/Tarefa.dart';
import 'package:tarefasdiarasapp/stores/Usuario.dart';

class SmashPage extends StatefulWidget {
  SmashPage({Key key}) : super(key: key);

  @override
  _SmashPageState createState() => _SmashPageState();
}

class _SmashPageState extends State<SmashPage> {
  Usuario user = new Usuario();
  bool isLogged = false;
  
  @override
  void initState() {
    user.getGoogleSignIn().isSignedIn().then((isLogged) {
      if(isLogged) {
        Navigator.pushNamed(context, "/");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        ToolBarComponent("Aguarde"),
        SliverFillRemaining(
          child: Center(
              child: RaisedButton(
            onPressed: () {
              this.user.login().then((v) {
                if (v != null) {
                  print(v);
                  Navigator.pushNamed(context, "/");
                }
              });
            },
            child: Text("Login"),
          )),
        )
      ],
    ));
  }
}
