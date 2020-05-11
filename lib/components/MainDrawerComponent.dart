import 'package:flutter/material.dart';
import 'package:tarefasdiarasapp/stores/Usuario.dart';

class MainDrawerComponent extends StatelessWidget {
  UsuarioStore user = new UsuarioStore();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Tarefas Diarias'),
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
