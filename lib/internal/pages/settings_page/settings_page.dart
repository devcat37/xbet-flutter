import 'package:flutter/material.dart';
import 'package:xbet_1/presentation/pages/settings_page/settings_page_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const routeName = '/settings-page';

  @override
  Widget build(BuildContext context) {
    return const SettingsPageView();
  }
}
