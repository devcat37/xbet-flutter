import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xbet_1/domain/models/favorite_team/favorite_team.dart';

class Settings {
  static const String appName = '1xBet Football Clubs';

  /// Зашифрованное хранилище локальных данных.
  late FlutterSecureStorage _storage;
  late Map<String, String> _secureValues;

  static const favoriteTeamsKey = 'favoriteTeams';

  Future<void> initFirebase() async {
    await Firebase.initializeApp();
  }

  Future initStorage() async {
    _storage = const FlutterSecureStorage();
    _secureValues = await _storage.readAll();
  }

  List<FavoriteTeam> get favoriteTeams =>
      (_secureValues[favoriteTeamsKey] ?? '{}').split(';').map((e) => FavoriteTeam.fromJson(jsonDecode(e))).toList();

  set favoriteTeams(List<FavoriteTeam> teams) {
    _secureValues[favoriteTeamsKey] = teams.map((e) => jsonEncode(e.toJson())).join(';');
    _storage.write(key: favoriteTeamsKey, value: teams.map((e) => jsonEncode(e.toJson())).join(';'));
  }
}
