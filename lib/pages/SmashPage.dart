import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefasdiarasapp/stores/Usuario.dart';

class SmashPage extends StatefulWidget {
  SmashPage({Key key}) : super(key: key);

  @override
  _SmashPageState createState() => _SmashPageState();
}

class _SmashPageState extends State<SmashPage> {
  UsuarioStore user = Modular.get<UsuarioStore>();
  bool isLogged = false;

  @override
  void initState() {
    user.getGoogleSignIn().isSignedIn().then((isLogged) {
      if (isLogged) {
        Navigator.of(context).pushReplacementNamed("/");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identifiquei-se!'),
        leading: Container(
          width: 0,
          height: 0,
        ),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Tarefas Diarias",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          ),
          RaisedButton(
            onPressed: () {
              this.user.login().then((v) {
                if (v != null) {
                  print(v);
                  Navigator.of(context).pushReplacementNamed("/");
                }
              });
            },
            child: Text("Entrar com o Google"),
          ),
        ],
      )),
    );
  }
}
