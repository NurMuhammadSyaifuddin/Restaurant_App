import 'dart:isolate';
import 'dart:ui';

import 'package:submission_3/main.dart';
import 'package:submission_3/model/restaurant.dart';
import 'package:submission_3/services/restaurant_service.dart';
import 'package:submission_3/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal(){
    _service = this;
  }

  factory BackgroundService() => _service ?? BackgroundService._internal();

  void initializeIsolate(){
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    Restaurant result = await RestaurantService().getRandomRestaurant();
    await notificationHelper.showNotification(flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}