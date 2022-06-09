import 'package:flutter/material.dart';
import 'package:xbet_1/data/repository/players_repository.dart';
import 'package:xbet_1/data/repository/teams_repository.dart';
import 'package:xbet_1/internal/application.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/services/settings.dart';
import 'package:xbet_1/internal/states/favorite_teams_state/favorite_teams_state.dart';
import 'package:xbet_1/internal/states/football_teams_state/football_teams_state.dart';
import 'package:xbet_1/internal/states/players_state/players_state.dart';
import 'package:xbet_1/internal/states/subscription_state/subscription_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Settings.
  final Settings settings = Settings();
  await settings.initFirebase();
  await settings.initStorage();
  service.registerSingleton(settings);

  // Repositories.
  service.registerLazySingleton<TeamsRepository>(() => TeamsRepository());
  service.registerLazySingleton<PlayersRepository>(() => PlayersRepository());

  // States.
  service.registerLazySingleton<FavoriteTeamsState>(() => FavoriteTeamsState());
  service.registerLazySingleton<FootballTeamsState>(() => FootballTeamsState());
  service.registerLazySingleton<SubscriptionState>(() => SubscriptionState());
  service.registerLazySingleton<PlayersState>(() => PlayersState());

  runApp(const Application());
}
