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
      ),
      body: Center(
          child: RaisedButton(
        onPressed: () {
          this.user.login().then((v) {
            if (v != null) {
              print(v);
              Navigator.of(context).pushReplacementNamed("/");
            }
          });
        },
        child: Text("Login"),
      )),
    );
  }
}
