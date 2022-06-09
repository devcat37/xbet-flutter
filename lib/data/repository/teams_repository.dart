import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xbet_1/domain/models/team/team.dart';

class TeamsRepository {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  Future<List<Team>> loadTeams() async {
    final ref = firestore.collection('teams');
    final data = await ref.get();

    return data.docs.map((e) => Team.fromJson(e.data())).toList();
  }
}
