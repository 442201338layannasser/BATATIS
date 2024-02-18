import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Views/Customer_View.dart';
import 'ViewMenuToCustomer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';


class NotificationServices {

  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance ;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin  = FlutterLocalNotificationsPlugin();



  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(BuildContext context, RemoteMessage message)async{
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings ,
        iOS: iosInitializationSettings
    );

    await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
      onDidReceiveNotificationResponse: (payload){
        print("onDidReceiveNotificationResponse");
          // handle interaction when app is active for android
          handleMessage(context, message);
      }
    );
  }

  void firebaseInit(BuildContext context){
print("i am here") ; 



    FirebaseMessaging.onMessage.listen((message) {
                print("straange");
                print("onDidReceiveNotificationResponse");

      RemoteNotification? notification = message.notification ;
      AndroidNotification? android = message.notification!.android ;
      

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('data:${message.data.toString()}');
      }
        if(kIsWeb){
                print("notifications web problem web");

        showNotification(message);

      }
      else if(Platform.isIOS){
                print("notifications web problem os");

        forgroundMessage();
      }
       
      else if(Platform.isAndroid){
                print("notifications web problem andro");

        initLocalNotifications(context, message);
        showNotification(message);
      }
     
    });
  }


  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true ,

    //web is different?
    // alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message)async{
        print("notifications web problemmmmmmm");

    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString() ,
      importance: Importance.max  ,
      showBadge: true ,
      playSound: true,
      //sound: const RawResourceAndroidNotificationSound('jetsons_doorbell')
    );

     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString() ,
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high ,
      playSound: true,
      ticker: 'ticker' ,
         sound: channel.sound
    //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
    //  icon: largeIconPath
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true ,
      presentBadge: true ,
      presentSound: true
    ) ;

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails
    );

    Future.delayed(Duration.zero , (){
              print("notifications web problemmmmmmm 22222222");

      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails ,
      );
    });

  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

Future<String> getDeviceTokenWeb() async {
    String? token = await messaging.getToken(
  vapidKey: "BH_CeruiJmsen8Z_WdLXSLisE_xq7jKj8W7HJ1jCcNbzy9IEWczzPYtkqDjSupOiAUjDvxCZ5Z9DYKpfrBLnYRo",
);
    return token!;

  }
  void isTokenRefresh()async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context)async{

    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null){
      handleMessage(context, initialMessage);
    }


    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      
      handleMessage(context, event);
    });

  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    print("handleMessage");
    if(message.data['type'] =='msj'){
      CHomePageState.changetab(1);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CHomePage()),
            (route) => false, // Remove all routes from the stack
          );
          
   }
  }


  Future forgroundMessage() async {
       print("forgroundMessage");
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


}