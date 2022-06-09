import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:xbet_1/internal/services/app_redirects.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/favorite_teams_state/favorite_teams_state.dart';
import 'package:xbet_1/internal/states/football_teams_state/football_teams_state.dart';
import 'package:xbet_1/internal/states/players_state/players_state.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    Future.wait([
      service<FootballTeamsState>().initialize(),
      service<PlayersState>().initialize(),
      service<FavoriteTeamsState>().initialize(),
    ]);

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Future.delayed(aSecond * 3, () => replaceWithWorkspace(context));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
