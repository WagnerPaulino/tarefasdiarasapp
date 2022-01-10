import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefasdiarasapp/config/NotificationConfig.dart';
import 'package:tarefasdiarasapp/stores/ThemeSwitch.dart';

import 'app_module.dart';

final NotificationConfig notificationConfig = NotificationConfig();
final ThemeSwitchStore themeSwitchStore = Modular.get<ThemeSwitchStore>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await notificationConfig.initializing();
  return runApp(ModularApp(
    module: AppModule(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        title: 'Tarefas',
        debugShowCheckedModeBanner: false,
        theme: themeSwitchStore.isLight ? ThemeData.light() : ThemeData.dark(),
        initialRoute: "/loading",
      ).modular(),
    );
  }
}
