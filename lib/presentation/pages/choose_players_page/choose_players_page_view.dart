import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/domain/models/player/player.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/create_team_state/create_team_state.dart';
import 'package:xbet_1/internal/states/football_teams_state/football_teams_state.dart';
import 'package:xbet_1/internal/states/players_state/players_state.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';
import 'package:xbet_1/presentation/global/team_wrapper/team_wrapper.dart';
import 'package:xbet_1/presentation/pages/choose_players_in_team/choose_players_in_team.dart';

class ChoosePlayersPageView extends StatelessWidget {
  const ChoosePlayersPageView({Key? key}) : super(key: key);

  FootballTeamsState get teamsState => service<FootballTeamsState>();
  CreateTeamState get createTeamState => service<CreateTeamState>();

  Widget _buildContent(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      itemCount: teamsState.teams.length,
      itemBuilder: (context, index) => Observer(
        builder: (context) => TeamWrapper(
          pickedPlayers: teamsState.teams
              .elementAt(index)
              .players
              .any((e) => createTeamState.players.map((player) => player.id).contains(e)),
          onPressed: () async {
            final List<Player>? players = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChoosePlayersInTeam(
                  team: teamsState.teams.elementAt(index),
                  chosenPlayers: createTeamState.players
                      .where((e) => teamsState.teams.elementAt(index).players.contains(e.id))
                      .toList(),
                  players: service<PlayersState>()
                      .players
                      .where(
                          (e) => teamsState.teams.elementAt(index).players.map((e) => e.trim()).contains(e.id.trim()))
                      .toList(),
                ),
              ),
            );

            if (players != null) createTeamState.setTeamPlayers(teamsState.teams.elementAt(index), players);
          },
          team: teamsState.teams.elementAt(index),
        ),
      ),
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Players choosing'),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: _buildContent(context),
    );
  }
}
