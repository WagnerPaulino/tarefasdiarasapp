import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  late String location; 

  Future initializing() async {
    await _configureLocalTimeZone();
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> agendarNotificacoesTarefas(List<Tarefa> tarefas) async {
    await this.initializing();
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
      tz.TZDateTime(tz.getLocation(location), DateTime.now().year, DateTime.now().month,
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

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
    this.location = timeZoneName;
  }

  Future<void> onSelectNotification(String? payLoad) async {
    if (payLoad != null) {
      print(payLoad);
    }
    return;
  }
}
