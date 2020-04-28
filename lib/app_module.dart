import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'main.dart';

class AppModule extends MainModule {
  // here will be any class you want to inject into your project (eg bloc, dependency)
  @override
  List<Bind> get binds => [];

  // here will be the routes of your module
  @override
  List<Router> get routers => [
        Router("/", child: (_, args) => MyHomePage(title: 'Aulas Flutter')),
      ];

  @override
  Widget get bootstrap => MyApp();
}
