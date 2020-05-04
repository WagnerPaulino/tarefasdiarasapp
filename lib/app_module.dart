import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefasdiarasapp/pages/EditTarefaPage.dart';
import 'package:tarefasdiarasapp/pages/HomePage.dart';
import 'package:tarefasdiarasapp/pages/SmashPage.dart';

import 'main.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router("/", child: (_, args) => MyHomePage()),
        Router("/loading", child: (_, args) => SmashPage()),
        Router('/edit-tarefa', child: (_, args) => EditTarefaPage()),
        Router('/edit-tarefa/:tarefaKey',
            child: (_, args) => EditTarefaPage(
                  tarefaKey: args.params['tarefaKey'],
                )),
      ];

  @override
  Widget get bootstrap => MyApp();
}
