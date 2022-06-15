import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/domain/models/player/player.dart';
import 'package:xbet_1/domain/models/team/team.dart';
import 'package:xbet_1/internal/services/app_redirects.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/create_team_state/create_team_state.dart';
import 'package:xbet_1/internal/states/football_teams_state/football_teams_state.dart';
import 'package:xbet_1/internal/states/players_state/players_state.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';
import 'package:xbet_1/presentation/global/team_wrapper/team_wrapper.dart';
import 'package:xbet_1/presentation/pages/choose_players_in_team/choose_players_in_team.dart';

class ChoosePlayersPageView extends StatefulWidget {
  const ChoosePlayersPageView({
    Key? key,
    this.chosenPlayers = const {},
  }) : super(key: key);

  final Map<String, List<Player>> chosenPlayers;

  @override
  State<ChoosePlayersPageView> createState() => _ChoosePlayersPageViewState();
}

class _ChoosePlayersPageViewState extends State<ChoosePlayersPageView> {
  FootballTeamsState get teamsState => service<FootballTeamsState>();
  CreateTeamState get createTeamState => service<CreateTeamState>();

  Map<String, List<Player>> _players = {};

  List<Player> get players {
    List<Player> pls = [];

    for (List<Player> pl in _players.values) {
      pls.addAll(pl);
    }

    return pls;
  }

  @override
  void initState() {
    if (widget.chosenPlayers.isNotEmpty) {
      _players = widget.chosenPlayers;
    }
    super.initState();
  }

  void choosePlayers() {
    for (String team in _players.keys) {
      createTeamState.setTeamPlayers(team, _players[team] ?? []);
    }
  }

  Widget _buildChoosePlayersButton(BuildContext context) {
    if (players.length != 11) return const SizedBox.shrink();

    return InkWell(
      borderRadius: borderRadius16,
      onTap: () {
        choosePlayers();
        pop(context);
      },
      child: AnimatedContainer(
        duration: defaultAnimationDuration,
        height: 56.h,
        width: MediaQuery.of(context).size.width - 2 * 16.w,
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: borderRadius16,
        ),
        child: Center(
          child: Text(
            'Choose your players',
            style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: whiteColor),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      itemCount: teamsState.teams.length,
      itemBuilder: (context, index) => Observer(
        builder: (context) {
          final Team team = teamsState.teams.elementAt(index);

          return TeamWrapper(
            pickedPlayers: team.players.any((e) => players.map((player) => player.id).contains(e)),
            onPressed: () async {
              final List<Player>? players = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChoosePlayersInTeam(
                    team: teamsState.teams.elementAt(index),
                    chosenPlayers: createTeamState.players.where((e) => team.players.contains(e.id)).toList(),
                    players: service<PlayersState>()
                        .players
                        .where((e) => team.players.map((e) => e.trim()).contains(e.id.trim()))
                        .toList(),
                  ),
                ),
              );

              setState(() {
                if (players != null) _players[team.id] = players;
              });
            },
            team: team,
          );
        },
      ),
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
    );
  }

  Widget _buildPlayersCount(BuildContext context) {
    return AnimatedContainer(
      duration: defaultAnimationDuration,
      height: 24.r,
      width: 24.r,
      decoration: BoxDecoration(
        color: players.isEmpty ? Colors.transparent : blueColor,
        shape: BoxShape.circle,
      ),
      child: players.isEmpty
          ? null
          : Center(
              child: Text(
                players.length.toString(),
                style: TextStyle(fontSize: 12.w, fontWeight: FontWeight.w500, color: whiteColor),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Players choosing'),
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: _buildPlayersCount(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildContent(context),
                SizedBox(height: 128.h),
              ],
            ),
          ),
          Positioned(
            bottom: 16.h + MediaQuery.of(context).padding.bottom,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _buildChoosePlayersButton(context),
            ),
          ),
        ],
      ),
    );
  }
}
