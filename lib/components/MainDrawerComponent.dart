import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tarefasdiarasapp/stores/Usuario.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainDrawerComponent extends StatelessWidget {
  UsuarioStore user = Modular.get<UsuarioStore>();

  Future<GoogleSignInAccount> loadUser() {
    return user.getGoogleSignIn().signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Text('Tarefas Diarias'),
                FutureBuilder<GoogleSignInAccount>(
                    future: loadUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return snapshot.data.email == null
                            ? Text(snapshot.data.displayName)
                            : Text(snapshot.data.email);
                      } else {
                        return Text('');
                      }
                    })
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Inicio'),
            onTap: () {
              user.navTo(context, "/");
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              user.logout().then((v) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/loading', (Route<dynamic> route) => false);
              });
            },
          ),
        ],
      ),
    );
  }
}
