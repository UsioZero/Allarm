//LIBRARIES
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SimpleNotification {
  DateTime _dateTime = DateTime.now();
  get dateTime => _dateTime;

  var cardHeight = 0.0;
  bool isShowNotify = true;

  static const AndroidNotificationDetails _androidDetails =
      AndroidNotificationDetails(
          'channel id', 'channel name', 'channel description',
          importance: Importance.Max,
          priority: Priority.High,
          ticker: 'test ticker',
          sound: RawResourceAndroidNotificationSound('alarm_sound'));
  static const IOSNotificationDetails _iosDetails = IOSNotificationDetails();
  NotificationDetails _notificationDetails =
      NotificationDetails(_androidDetails, _iosDetails);

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  SimpleNotification(androidCallback, iosCallback) {
    this._dateTime = _dateTime;
    this.cardHeight = cardHeight;
    this.isShowNotify = isShowNotify;
    var initSetAndroid = new AndroidInitializationSettings('hourglasses');
    var initSetIos = new IOSInitializationSettings(
        onDidReceiveLocalNotification: iosCallback);
    var initSet = new InitializationSettings(initSetAndroid, initSetIos);

    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    _flutterLocalNotificationsPlugin.initialize(initSet,
        onSelectNotification: androidCallback);
  }

  void notify(DateTime dayTime, int id) {
    _dateTime =dayTime;
    if(isShowNotify)
    _flutterLocalNotificationsPlugin.schedule(
        id,
        "Time is over",
        "It's adventure time",
        dayTime,
        //  Day(dayTime.weekday),
        // Time(dayTime.hour, dayTime.minute),
        _notificationDetails);
  }
}
