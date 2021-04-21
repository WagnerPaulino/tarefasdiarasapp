import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefasdiarasapp/pages/EditTarefaPage.dart';
import 'package:tarefasdiarasapp/pages/HomePage.dart';
import 'package:tarefasdiarasapp/pages/SmashPage.dart';
import 'package:tarefasdiarasapp/stores/Tarefa.dart';
import 'package:tarefasdiarasapp/stores/Usuario.dart';

class AppModule extends Module {
  AppModule();

  @override
  final List<Bind> binds = [
    Bind<UsuarioStore>((i) => UsuarioStore()),
    Bind<TarefaStore>((i) => TarefaStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, args) => MyHomePage()),
    ChildRoute("/loading", child: (_, args) => SmashPage()),
    ChildRoute('/edit-tarefa', child: (_, args) => EditTarefaPage()),
    ChildRoute('/edit-tarefa/:tarefaKey',
        child: (_, args) => EditTarefaPage(
              tarefaKey: args.params['tarefaKey'],
            )),
  ];
}
