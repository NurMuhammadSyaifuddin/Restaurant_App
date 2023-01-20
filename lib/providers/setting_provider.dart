import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/background_service.dart';
import '../utils/datetime_helper.dart';

class SettingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  static const String notificationPrefs = 'notification';

  Future<bool> scheduleNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(notificationPrefs, _isScheduled);
      return await AndroidAlarmManager.periodic(
          const Duration(hours: 24), 1, BackgroundService.callback,
          startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(notificationPrefs, false);
    return await AndroidAlarmManager.cancel(1);
  }
}
