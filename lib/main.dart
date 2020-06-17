import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefasdiarasapp/pages/HomePage.dart';

import 'app_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  return runApp(ModularApp(module: AppModule(firstCamera)));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: "/loading",
      navigatorKey: Modular.navigatorKey,
      onGenerateRoute: Modular.generateRoute,
      home: MyHomePage(),
    );
  }
}
