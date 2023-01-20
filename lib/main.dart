import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:submission_3/pages/add_review_page.dart';
import 'package:submission_3/pages/detail_restaurant_page.dart';
import 'package:submission_3/pages/favorite_page.dart';
import 'package:submission_3/pages/home_page.dart';
import 'package:submission_3/pages/settings_page.dart';
import 'package:submission_3/pages/splash_screen_page.dart';
import 'package:submission_3/providers/favorite_restaurant_provider.dart';
import 'package:submission_3/providers/restaurant_provider.dart';
import 'package:submission_3/providers/setting_provider.dart';
import 'package:submission_3/services/restaurant_service.dart';
import 'package:submission_3/utils/background_service.dart';
import 'package:submission_3/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService backgroundService = BackgroundService();
  backgroundService.initializeIsolate();

  await AndroidAlarmManager.initialize();
  await notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                RestaurantProvider(service: RestaurantService())),
        ChangeNotifierProvider(
            create: (context) => FavoriteRestaurantProvider()),
        ChangeNotifierProvider(create: (context) => SettingProvider())
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home_page': (context) => const HomePage(),
          '/detail_page': (context) => DetailRestaurantPage(
              restaurant: (ModalRoute.of(context)?.settings.arguments
                  as List<dynamic>)[0],
              isFavoritePage: (ModalRoute.of(context)?.settings.arguments
                  as List<dynamic>)[1]),
          '/add_review': (context) => AddReviewPage(
              idRestaurant: (ModalRoute.of(context)?.settings.arguments!
                  as List<dynamic>)[0],
              provider: (ModalRoute.of(context)?.settings.arguments!
                  as List<dynamic>)[1]),
          '/favorite_page': (context) => const FavoritePage(),
          '/settings_page': (context) => SettingPage()
        },
      ),
    );
  }
}
