import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:xbet_1/data/repository/teams_repository.dart';
import 'package:xbet_1/domain/models/team/team.dart';
import 'package:xbet_1/internal/services/service_locator.dart';

part 'football_teams_state.g.dart';

class FootballTeamsState = _FootballTeamsStateBase with _$FootballTeamsState;

abstract class _FootballTeamsStateBase with Store {
  TeamsRepository get repository => service<TeamsRepository>();

  @observable
  ObservableList<Team> teams = ObservableList();

  Future<void> _loadTeams() async {
    teams = ObservableList.of(await repository.loadTeams());
    log('[TEAMS]: Загружено ${teams.length} команд!');
  }

  Future<void> initialize() async {
    await _loadTeams();
  }
}
