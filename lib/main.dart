import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefasdiarasapp/config/NotificationConfig.dart';

import 'app_module.dart';

final NotificationConfig notificationConfig = NotificationConfig();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await notificationConfig.initializing();
  return runApp(ModularApp(module: AppModule(), child: MyApp(),));
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
    ).modular();
  }
}
