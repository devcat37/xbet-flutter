// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_team_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateTeamState on _CreateTeamStateBase, Store {
  Computed<List<Player>>? _$playersComputed;

  @override
  List<Player> get players =>
      (_$playersComputed ??= Computed<List<Player>>(() => super.players,
              name: '_CreateTeamStateBase.players'))
          .value;

  late final _$teamNameAtom =
      Atom(name: '_CreateTeamStateBase.teamName', context: context);

  @override
  String get teamName {
    _$teamNameAtom.reportRead();
    return super.teamName;
  }

  @override
  set teamName(String value) {
    _$teamNameAtom.reportWrite(value, super.teamName, () {
      super.teamName = value;
    });
  }

  late final _$_playersAtom =
      Atom(name: '_CreateTeamStateBase._players', context: context);

  @override
  ObservableMap<String, List<Player>> get _players {
    _$_playersAtom.reportRead();
    return super._players;
  }

  @override
  set _players(ObservableMap<String, List<Player>> value) {
    _$_playersAtom.reportWrite(value, super._players, () {
      super._players = value;
    });
  }

  late final _$fileAtom =
      Atom(name: '_CreateTeamStateBase.file', context: context);

  @override
  Uint8List get file {
    _$fileAtom.reportRead();
    return super.file;
  }

  @override
  set file(Uint8List value) {
    _$fileAtom.reportWrite(value, super.file, () {
      super.file = value;
    });
  }

  @override
  String toString() {
    return '''
teamName: ${teamName},
file: ${file},
players: ${players}
    ''';
  }
}
