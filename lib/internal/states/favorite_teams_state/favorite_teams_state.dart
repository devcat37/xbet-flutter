import 'package:mobx/mobx.dart';
import 'package:xbet_1/domain/models/favorite_team/favorite_team.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/services/settings.dart';

part 'favorite_teams_state.g.dart';

class FavoriteTeamsState = _FavoriteTeamsStateBase with _$FavoriteTeamsState;

abstract class _FavoriteTeamsStateBase with Store {
  @observable
  ObservableList<FavoriteTeam> teams = ObservableList();

  void addTeamToFavorite(FavoriteTeam team) {
    teams.add(team);

    service<Settings>().favoriteTeams = teams;
  }

  void deleteTeam(FavoriteTeam team) {
    teams.remove(team);

    service<Settings>().favoriteTeams = teams;
  }

  Future<void> initialize() async {
    teams = ObservableList.of(service<Settings>().favoriteTeams);
  }
}
