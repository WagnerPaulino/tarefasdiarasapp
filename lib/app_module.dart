import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/src/routers/modular_router.dart';
import 'package:tarefasdiarasapp/pages/EditTarefaPage.dart';
import 'package:tarefasdiarasapp/pages/HomePage.dart';
import 'package:tarefasdiarasapp/pages/SmashPage.dart';
import 'package:tarefasdiarasapp/stores/Tarefa.dart';
import 'package:tarefasdiarasapp/stores/Usuario.dart';
import 'main.dart';

class AppModule extends MainModule {
  
  AppModule();
  
  @override
  List<Bind> get binds => [
    Bind<UsuarioStore>((i) => UsuarioStore()),
    Bind<TarefaStore>((i) => TarefaStore()),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter("/", child: (_, args) => MyHomePage()),
    ModularRouter("/loading", child: (_, args) => SmashPage()),
    ModularRouter('/edit-tarefa',
            child: (_, args) => EditTarefaPage()),
    ModularRouter('/edit-tarefa/:tarefaKey',
            child: (_, args) => EditTarefaPage(
                  tarefaKey: args.params['tarefaKey'],
                )),
      ];

  @override
  Widget get bootstrap => MyApp();
}
