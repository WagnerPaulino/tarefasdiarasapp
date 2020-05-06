import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefasdiarasapp/pages/HomePage.dart';
import 'package:tarefasdiarasapp/pages/SmashPage.dart';
import 'package:tarefasdiarasapp/stores/Usuario.dart';

import 'app_module.dart';

void main() {
  Usuario user = Usuario();
  
  return runApp(ModularApp(module: AppModule(user.getGoogleSignIn().currentUser)));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/loading",
      onGenerateRoute: Modular.generateRoute,
      home: MyHomePage(),
    );
  }
}
