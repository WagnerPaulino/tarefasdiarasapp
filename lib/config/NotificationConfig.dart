import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:tarefasdiarasapp/models/Tarefa.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationConfig {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings? androidInitializationSettings;
  IOSInitializationSettings? iosInitializationSettings;
  late InitializationSettings initializationSettings;

  Future<void> initializing() async {
    String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    var loc = tz.getLocation(currentTimeZone);
    tz.setLocalLocation(loc);
    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  NotificationConfig() {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    
  }

  Future<void> agendarNotificacoesTarefas(List<Tarefa> tarefas) async {
    for (int i = 0; i < tarefas.length; i++) {
      if (tarefas[i].timeOfDay != null) {
        String? body = tarefas[i].detalhe == null
            ? 'Detalhe não fornecido'
            : tarefas[i].detalhe;
        await this.notificationConfig(i, tarefas[i].nome, body,
            Time(tarefas[i].timeOfDay!.hour, tarefas[i].timeOfDay!.minute, 0));
      }
    }
  }

  Future<void> notificationConfig(
      int id, String? title, String? body, Time time) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime(tz.local, DateTime.now().year, DateTime.now().month, DateTime.now().day,
          time.hour, time.minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'tarefadiariaID', 'tarefadiariaTitle',
            priority: Priority.high,
            importance: Importance.max,
            ticker: 'tarefasdiarias'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payLoad) async {
    print("notificações disparada");
    return CupertinoAlertDialog(
      title: Text(title!),
      content: Text(body!),
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

  Future<void> onSelectNotification(String? payLoad) async {
    if (payLoad != null) {
      print(payLoad);
    }
    return;
  }
}
