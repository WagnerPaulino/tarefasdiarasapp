import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tarefasdiarasapp/models/Tarefa.dart';

class NotificationConfig {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  Future initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> agendarNotificacoesTarefas(List<Tarefa> tarefas) async {
    await this.initializing();
    for (int i = 0; i < tarefas.length; i++) {
      if (tarefas[i].timeOfDay != null) {
        String body = tarefas[i].detalhe == null
            ? 'Detalhe não fornecido'
            : tarefas[i].detalhe;
        await this.notificationConfig(i, tarefas[i].nome, body,
            Time(tarefas[i].timeOfDay.hour, tarefas[i].timeOfDay.minute, 0));
      }
    }
  }

  Future<void> notificationConfig(
      int id, String title, String body, Time time) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'tarefadiariaID', 'tarefadiariaTitle', 'tarefadiariaDescription',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'tarefasdiarias');
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, time, notificationDetails);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payLoad) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            print('');
          },
          child: Text("Okay"),
        )
      ],
    );
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }
  }
}
