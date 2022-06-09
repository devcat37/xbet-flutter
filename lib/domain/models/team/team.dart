import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

@JsonSerializable(explicitToJson: true)
class Team {
  const Team({
    required this.id,
    required this.image,
    required this.name,
    this.players = const [],
    this.country = '',
    this.played = 0,
    this.lost = 0,
    this.won = 0,
    this.draws = 0,
    this.points = 0,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);

  final String id;

  final String image;
  final String name;

  final String country;

  final List<String> players;

  final int played;
  final int lost;
  final int won;
  final int draws;

  final int points;
}
