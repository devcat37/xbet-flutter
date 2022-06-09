import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@JsonSerializable(explicitToJson: true)
class Player {
  const Player({
    required this.id,
    required this.image,
    required this.name,
    this.position = '',
    this.countries = const [],
    this.number = 0,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  final String id;

  final String image;
  final String name;
  final String position;

  final List<String> countries;

  final int number;
}
