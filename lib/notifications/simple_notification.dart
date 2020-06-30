//LIBRARIES
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SimpleNotification {
  TimeOfDay _dateTime = TimeOfDay.now();
  get dateTime => _dateTime;

  bool isExpanded = false;
  BuildContext context;

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

  SimpleNotification(this.context) {
    this._dateTime = _dateTime;
    var initSetAndroid = new AndroidInitializationSettings('hourglasses');
    var initSetIos = new IOSInitializationSettings(
        onDidReceiveLocalNotification: _onIOSSelectNotification);
    var initSet = new InitializationSettings(initSetAndroid, initSetIos);

    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    _flutterLocalNotificationsPlugin.initialize(initSet,
        onSelectNotification: _onAndroidSelectNotification);
  }

  void cancel(int notificationId) {
    _flutterLocalNotificationsPlugin.cancel(7 * notificationId);
    _flutterLocalNotificationsPlugin.cancel(7 * notificationId + 1);
    _flutterLocalNotificationsPlugin.cancel(7 * notificationId + 2);
    _flutterLocalNotificationsPlugin.cancel(7 * notificationId + 3);
    _flutterLocalNotificationsPlugin.cancel(7 * notificationId + 4);
    _flutterLocalNotificationsPlugin.cancel(7 * notificationId + 5);
    _flutterLocalNotificationsPlugin.cancel(7 * notificationId + 6);
  }

  void notify(
      TimeOfDay time, int notificationId, List<bool> daySel, bool isFirstTime) {
    cancel(notificationId);
    _dateTime = time;
    if (isFirstTime) {
      _flutterLocalNotificationsPlugin.schedule(
          7 * notificationId,
          "Time is over",
          "It's adventure time",
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, time.hour, time.minute),
          _notificationDetails);
    } else {
      print('$time');
      if (daySel[0]) {
        print('go');
        _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            7 * notificationId + 1,
            "Time is over",
            "It's adventure time",
            Day.Monday,
            Time(time.hour, time.minute),
            _notificationDetails);
      }
      if (daySel[1]) {
        print('go');
        _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            7 * notificationId + 1,
            "Time is over",
            "It's adventure time",
            Day.Tuesday,
            Time(time.hour, time.minute),
            _notificationDetails);
      }

      if (daySel[2]) {
        print('go');
        _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            7 * notificationId + 2,
            "Time is over",
            "It's adventure time",
            Day.Wednesday,
            Time(time.hour, time.minute),
            _notificationDetails);
      }

      if (daySel[3]) {
        print('go');
        _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            7 * notificationId + 3,
            "Time is over",
            "It's adventure time",
            Day.Thursday,
            Time(time.hour, time.minute),
            _notificationDetails);
      }
      if (daySel[4]) {
        print('go');
        _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            7 * notificationId + 4,
            "Time is over",
            "It's adventure time",
            Day.Friday,
            Time(time.hour, time.minute),
            _notificationDetails);
      }
      if (daySel[5]) {
        print('go');
        _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            7 * notificationId + 5,
            "Time is over",
            "It's adventure time",
            Day.Saturday,
            Time(time.hour, time.minute),
            _notificationDetails);
      }
      if (daySel[6]) {
        print('go');
        _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            7 * notificationId + 6,
            "Time is over",
            "It's adventure time",
            Day.Sunday,
            Time(time.hour, time.minute),
            _notificationDetails);
      }
    }
  }

  Future _onAndroidSelectNotification(String payload) {
    return Navigator.of(context).pushNamed('/alert');
  }

  Future _onIOSSelectNotification(
      int id, String title, String body, String payload) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              return Navigator.of(context).pushNamed('/alert');
            },
          )
        ],
      ),
    );
  }
}
