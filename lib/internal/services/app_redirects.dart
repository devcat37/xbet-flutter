import 'package:flutter/material.dart';
import 'package:xbet_1/domain/models/team/team.dart';
import 'package:xbet_1/internal/pages/create_team_page/create_team_page.dart';
import 'package:xbet_1/internal/pages/subscription_page/subscription_page.dart';
import 'package:xbet_1/internal/pages/team_details_page/team_details_page.dart';
import 'package:xbet_1/internal/pages/workspace.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/create_team_state/create_team_state.dart';

void pop(BuildContext context) => Navigator.of(context).pop();

/// Переход на главную страницу.
void replaceWithWorkspace(BuildContext context) => Navigator.of(context).pushReplacementNamed(Workspace.routeName);

/// Переход на страницу подписок.
void goToSubscriptionPage(BuildContext context) => Navigator.of(context).pushNamed(SubscriptionPage.routeName);

/// Переход на страницу информации о команде.
void goToTeamDetailsPage(BuildContext context, {required Team team}) =>
    Navigator.of(context).pushNamed(TeamDetailsPage.routeName, arguments: team);

Future<void> goToCreateTeamPage(BuildContext context) async {
  final state = CreateTeamState();

  service.registerSingleton(state);
  await Navigator.of(context).pushNamed(CreateTeamPage.routeName);

  service.unregister(instance: state);
}
