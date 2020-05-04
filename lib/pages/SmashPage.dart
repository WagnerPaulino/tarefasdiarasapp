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
  Widget build(BuildContext context) {
    this.user.getGoogleSignIn().onCurrentUserChanged.asBroadcastStream().listen((v) {
      this.isLogged = v != null;
    });
    this.isLogged = this.user.getGoogleSignIn().currentUser != null;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        ToolBarComponent("Aguarde"),
        SliverFillRemaining(
          child: Center(
              child: isLogged == null
                  ? RaisedButton(
                      child: Text("Logout"),
                      onPressed: () {
                        this.user.logout();
                      },
                    )
                  : RaisedButton(
                      onPressed: () {
                        this.user.login().then((v) {
                          if (v.id != null) {
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
