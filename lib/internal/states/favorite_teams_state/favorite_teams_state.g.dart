// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_teams_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteTeamsState on _FavoriteTeamsStateBase, Store {
  late final _$teamsAtom =
      Atom(name: '_FavoriteTeamsStateBase.teams', context: context);

  @override
  ObservableList<FavoriteTeam> get teams {
    _$teamsAtom.reportRead();
    return super.teams;
  }

  @override
  set teams(ObservableList<FavoriteTeam> value) {
    _$teamsAtom.reportWrite(value, super.teams, () {
      super.teams = value;
    });
  }

  @override
  String toString() {
    return '''
teams: ${teams}
    ''';
  }
}
