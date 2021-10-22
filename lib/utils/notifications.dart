//initNotifications (): lo necesitamos para inicializar la configuración de notificaciones para Android, iOS y macOS. Para Android, queremos usar un ícono para nuestra notificación. Lo que llamamos app_icon(explicado en la siguiente sección).
//pushNotification (): necesitamos algunos detalles generales del canal para configurar, que es necesario configurar para Android 8.0+. Tiene toda una variedad de opciones (más de las mostradas). Ahora finalmente estamos en la parte de la notificación que desea mostrar; flutterLocalNotificationsPlugin.show(<your-displayed-notification>). Aquí especificas una identificación, título y contenido de tu notificación, todo esto habla por sí mismo. Pero también hay carga útil;
//selectNotification (): es el último método, se activará cuando se seleccione la notificación.
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications_Remember {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  DateTime dateTime = DateTime(2021);

  void initNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> pushNotification(String recordatorio) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'push_messages: 0',
      'push_messages: push_messages',
      'push_messages: A new Flutter project',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      enableVibration: true,
      //timeoutAfter: ,//tiempo que dura la notification
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'DiaBits',
        'Recordatorio <${recordatorio}>.', platformChannelSpecifics,
        payload: 'item x');
  }

  Future selectNotification(String payload) async {
    // some action...
  }
}
