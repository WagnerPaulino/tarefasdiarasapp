import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefasdiarasapp/pages/EditTarefaPage.dart';
import 'package:tarefasdiarasapp/pages/HomePage.dart';
import 'package:tarefasdiarasapp/pages/SmashPage.dart';
import 'package:tarefasdiarasapp/stores/Usuario.dart';

import 'guards/AuthGuard.dart';
import 'main.dart';

class AppModule extends MainModule {

  final CameraDescription camera;
  
  AppModule(this.camera);
  
  @override
  List<Bind> get binds => [
    Bind<UsuarioStore>((i) => UsuarioStore()),
  ];

  @override
  List<Router> get routers => [
        Router("/", child: (_, args) => MyHomePage(), guards: [AuthGuard()]),
        Router("/loading", child: (_, args) => SmashPage()),
        Router('/edit-tarefa',
            child: (_, args) => EditTarefaPage(camera: this.camera,)),
        Router('/edit-tarefa/:tarefaKey',
            child: (_, args) => EditTarefaPage(
              camera: this.camera,
                  tarefaKey: args.params['tarefaKey'],
                )),
      ];

  @override
  Widget get bootstrap => MyApp();
}
