import 'package:flutter/material.dart';
import 'package:xbet_1/domain/models/team/team.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/players_state/players_state.dart';
import 'package:xbet_1/presentation/pages/team_details_page/team_details_page_view.dart';

class TeamDetailsPage extends StatelessWidget {
  const TeamDetailsPage({
    Key? key,
    required this.team,
  }) : super(key: key);

  static const routeName = '/team-details-page';

  final Team team;

  @override
  Widget build(BuildContext context) {
    return TeamDetailsPageView(
      team: team,
      players: service<PlayersState>()
          .players
          .where((e) => team.players.map((e) => e.trim()).contains(e.id.trim()))
          .toList(),
    );
  }
}
