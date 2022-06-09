import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:xbet_1/domain/models/player/player.dart';

part 'favorite_team.g.dart';

@JsonSerializable(explicitToJson: true)
class FavoriteTeam {
  const FavoriteTeam({
    required this.title,
    required this.players,
    this.image,
  });

  factory FavoriteTeam.fromJson(Map<String, dynamic> json) => _$FavoriteTeamFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteTeamToJson(this);

  final String title;

  final List<int>? image;
  final List<Player> players;
}
