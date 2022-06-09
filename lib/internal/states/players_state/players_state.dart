import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:xbet_1/data/repository/players_repository.dart';
import 'package:xbet_1/domain/models/player/player.dart';
import 'package:xbet_1/internal/services/service_locator.dart';

part 'players_state.g.dart';

class PlayersState = _PlayersStateBase with _$PlayersState;

abstract class _PlayersStateBase with Store {
  PlayersRepository get repository => service<PlayersRepository>();

  @observable
  ObservableList<Player> players = ObservableList();

  Future<void> _loadPlayers() async {
    players = ObservableList.of(await repository.loadPlayers());
    log('[PLAYERS]: Загружено ${players.length} игроков!');
  }

  Future<void> initialize() async {
    await _loadPlayers();
  }
}
