import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tarefasdiarasapp/stores/Tarefa.dart';
import 'package:tarefasdiarasapp/stores/ThemeSwitch.dart';
import 'package:tarefasdiarasapp/stores/Usuario.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainDrawerComponent extends StatelessWidget {
  final UsuarioStore user = Modular.get<UsuarioStore>();
  final TarefaStore tarefaStore = Modular.get<TarefaStore>();
  final ThemeSwitchStore themeSwitchStore = Modular.get<ThemeSwitchStore>();

  Future<GoogleSignInAccount?> loadUser() {
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
                FutureBuilder<GoogleSignInAccount?>(
                    future: loadUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return renderPhotoUser(snapshot.data!);
                      } else {
                        return Text('');
                      }
                    })
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text('Trocar Tema'),
            onTap: () {
              this.themeSwitchStore.changeTheme();
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              user.logout().then((v) {
                tarefaStore.tarefas = [];
                Modular.to.navigate('/loading', replaceAll: true);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget renderPhotoUser(GoogleSignInAccount usuario) {
    return Center(
      child: Column(
        children: getPhotoWithNameFromUsuario(usuario),
      ),
    );
  }

  String getEmailOrNameFromUsuario(GoogleSignInAccount usuario) {
    return usuario.email == null ? usuario.displayName! : usuario.email;
  }

  List<Widget> getPhotoWithNameFromUsuario(GoogleSignInAccount usuario) {
    if (usuario.photoUrl == null) {
      return [
        Icon(Icons.person),
        Text(getEmailOrNameFromUsuario(usuario)),
      ];
    } else {
      return [
        CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(usuario.photoUrl!),
        ),
        Text(getEmailOrNameFromUsuario(usuario)),
      ];
    }
  }
}
