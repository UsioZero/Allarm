import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Allarm extends StatefulWidget {

  Widget build(BuildContext context) {
    return  MaterialApp(
          title: 'Clock',
          theme: ThemeData(
            primarySwatch: Colors.yellow,
            textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white))
          ),
      );
  }

  @override
  _Allarm createState() => _Allarm();
}

class _Allarm extends State<Allarm> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
      new FlutterLocalNotificationsPlugin();
  var initSetAndroid;
  var initSetIos;
  var initSet;

    void _showNotificaton() async{
      await _demoNotify();
  }

  Future<void> _demoNotify() async{
    var androidChannelSpecifics = AndroidNotificationDetails(
      'channel id', 
      'channel name', 
      'channel description',
      importance: Importance.Max, 
      priority: Priority.High, 
      ticker: 'test ticker'
      );
    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = 
      NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, 
      'Hello bro', 
      'Its a body bro', 
      platformChannelSpecifics,
      payload: 'test payload'
    );
  }

  @override
  void initState() {
    super.initState();
    initSetAndroid = 
        new AndroidInitializationSettings('hourglasses');
    initSetIos = 
        new IOSInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification
        );
    initSet = new InitializationSettings(initSetAndroid, initSetIos);
    flutterLocalNotificationsPlugin.initialize(
      initSet,
      onSelectNotification: onSelectNotification
    );
  }

  Future onSelectNotification(String payload) async{
    if(payload != null){
      debugPrint('Notify payload: $payload');
    }
    await Navigator.push(
      context, 
      new MaterialPageRoute(builder: (context)=> new SecondRoute())
    );
  }

  Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload
  ) async{
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async{
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => SecondRoute()
                )
              );
            },
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clock'),
        leading: Container(
          child: Icon(Icons.alarm, color: Colors.black87),
          padding: EdgeInsets.only(right: 5),               
          ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNotificaton,
        tooltip: 'Increment',
        child: Icon(Icons.alarm_on),
      ), 
    );
  }
}

class SecondRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AllertPage')),
      body: Center(child: RaisedButton(
        child: Text('go back'),
        onPressed: (){Navigator.pop(context);},
    ),),
    );
  }
  
}