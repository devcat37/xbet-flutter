import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/domain/models/team/team.dart';
import 'package:xbet_1/internal/pages/create_team_page/create_team_page.dart';
import 'package:xbet_1/internal/pages/settings_page/settings_page.dart';
import 'package:xbet_1/internal/pages/splash_screen/splash_screen.dart';
import 'package:xbet_1/internal/pages/subscription_page/subscription_page.dart';
import 'package:xbet_1/internal/pages/team_details_page/team_details_page.dart';
import 'package:xbet_1/internal/pages/workspace.dart';
import 'package:xbet_1/internal/services/settings.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        title: Settings.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          fontFamily: 'SfProDisplay',
        ),
        initialRoute: '/',
        onGenerateRoute: (routeSettings) {
          Route? route;

          switch (routeSettings.name) {
            case SplashScreen.routeName:
              route = MaterialPageRoute(builder: (context) => const SplashScreen());
              break;
            case Workspace.routeName:
              route = MaterialPageRoute(builder: (context) => const Workspace());
              break;
            case SubscriptionPage.routeName:
              route = MaterialPageRoute(builder: (context) => const SubscriptionPage());
              break;
            case SettingsPage.routeName:
              route = MaterialPageRoute(builder: (context) => const SettingsPage());
              break;
            case CreateTeamPage.routeName:
              route = MaterialPageRoute(builder: (context) => const CreateTeamPage());
              break;
            case TeamDetailsPage.routeName:
              route = MaterialPageRoute(builder: (context) => TeamDetailsPage(team: routeSettings.arguments as Team));
              break;
          }

          return route;
        },
      ),
    );
  }
}
