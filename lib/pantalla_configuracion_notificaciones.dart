import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;


class Configuracion extends StatefulWidget {
  @override
  _ConfiguracionState createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Variables para almacenar la configuración seleccionada
  List<int> selectedDays = [];
  TimeOfDay selectedTime = TimeOfDay(hour: 7, minute: 0);

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Maneja la respuesta a la notificación aquí si es necesario
      },
    );

    // Solicitar permisos (si es necesario)
    final AndroidFlutterLocalNotificationsPlugin? androidFlutterLocalNotificationsPlugin =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    await androidFlutterLocalNotificationsPlugin?.requestPermission();
  }

  void _scheduleWeeklyNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'weekly_notification_channel_id',
      'Weekly Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    for (int day in selectedDays) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        day,
        'Weekly Reminder',
        'This is your weekly reminder!',
        _nextInstanceOfDayAndTime(day, Time(selectedTime.hour, selectedTime.minute)),
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  tz.TZDateTime _nextInstanceOfDayAndTime(int day, Time time) {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }
    return scheduledDate;
  }

  void _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _selectDay(bool selected, int day) {
    setState(() {
      if (selected) {
        selectedDays.add(day);
      } else {
        selectedDays.remove(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración de notificaciones'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              children: List<Widget>.generate(7, (int index) {
                return ChoiceChip(
                  label: Text(
                    ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'][index],
                  ),
                  selected: selectedDays.contains(index + 1),
                  onSelected: (bool selected) {
                    _selectDay(selected, index + 1);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickTime,
              child: Text('Seleccionar hora'),
            ),
            Text('Hora seleccionada: ${selectedTime.format(context)}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scheduleWeeklyNotification,
              child: Text('Programar notificación semanal'),
            ),
          ],
        ),
      ),
    );
  }
}
