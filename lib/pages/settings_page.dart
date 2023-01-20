import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_3/theme.dart';
import 'package:submission_3/widgets/bottom_nav.dart';

import '../providers/setting_provider.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  Future<void> getDataValueSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(SettingProvider.notificationPrefs) ?? false;

    // ignore: use_build_context_synchronously
    await Provider.of<SettingProvider>(context, listen: false)
        .scheduleNews(value);
  }

  @override
  void initState() {
    getDataValueSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content() => Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Restaurant Notification',
                    style: blackTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Consumer<SettingProvider>(
                        builder: (context, scheduled, _) => Switch.adaptive(
                            value: scheduled.isScheduled,
                            onChanged: (value) async {
                              scheduled.scheduleNews(value);
                            })))
              ],
            ),
          ),
        );

    return Scaffold(
      body: SafeArea(child: content()),
      bottomNavigationBar: const BottomNav(selected: TypeBottomNav.settings),
    );
  }
}
