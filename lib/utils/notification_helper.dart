import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import '../model/restaurant.dart';
import 'navigation_helper.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSetting =
        InitializationSettings(android: initializationSettingAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) async {
      final result = payload.payload;
      selectNotificationSubject.add(result ?? '');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurant restaurant) async {
    var channelId = '1';
    var channelName = 'channel_1';
    var channelDesc = 'restaurant_app';

    var androidPlatformChannelSpesifics = AndroidNotificationDetails(channelId, channelName,
    channelDescription: channelDesc, importance: Importance.max, priority: Priority.high,
    ticker: 'ticker',
    styleInformation: const DefaultStyleInformation(true, true));

    var platformChannelSpesifics = NotificationDetails(android: androidPlatformChannelSpesifics);
    var titleNotification = '<b>This restaurant might interest you</b>';
    var nameRestaurant = restaurant.name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      nameRestaurant,
      platformChannelSpesifics,
      payload: json.encode(restaurant.toMap())
    );
  }

  static void configureSelectNotificationSubject(String route){
    selectNotificationSubject.stream.listen((payload) async {
      Restaurant restaurant = Restaurant.fromJson(json.decode(payload));
      Navigation.intentWithData(route, restaurant);
    });
  }
}
