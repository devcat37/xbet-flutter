import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xbet_1/domain/models/player/player.dart';

class PlayersRepository {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  Future<List<Player>> loadPlayers() async {
    final ref = firestore.collection('players');
    final data = await ref.get();

    return data.docs.map((e) => Player.fromJson(e.data())).toList();
  }
}
