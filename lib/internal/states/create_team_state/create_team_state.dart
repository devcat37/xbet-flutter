import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:mobx/mobx.dart';
import 'package:xbet_1/domain/models/favorite_team/favorite_team.dart';
import 'package:xbet_1/domain/models/player/player.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/favorite_teams_state/favorite_teams_state.dart';

part 'create_team_state.g.dart';

class CreateTeamState = _CreateTeamStateBase with _$CreateTeamState;

abstract class _CreateTeamStateBase with Store {
  @observable
  String teamName = '';

  @observable
  ObservableMap<String, List<Player>> chosenPlayers = ObservableMap();

  @computed
  List<Player> get players {
    List<Player> pls = [];

    for (List<Player> pl in chosenPlayers.values) {
      pls.addAll(pl);
    }

    return pls;
  }

  @observable
  Uint8List file = Uint8List(0);

  Future<void> choosePhoto() async {
    // show a dialog to open a file.
    FilePickerCross myFile = await FilePickerCross.importFromStorage(
      type: FileTypeCross.image, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
    );

    log('Выбран файл: ' + myFile.fileName.toString());

    file = myFile.toUint8List();
    log('Размер: ' + (file.length / 1024 / 1024).toStringAsFixed(2) + ' МБайт');
  }

  void createTeam() {
    final FavoriteTeam team = FavoriteTeam(
      title: teamName,
      players: players,
      image: file,
    );
    service<FavoriteTeamsState>().addTeamToFavorite(team);
  }

  void setTeamName(String name) {
    teamName = name;
  }

  void setTeamPlayers(String team, List<Player> players) {
    chosenPlayers[team] = players;
  }

  void deletePhoto() {
    file = Uint8List(0);
  }
}
