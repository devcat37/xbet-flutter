// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: json['id'] as String,
      image: json['image'] as String,
      name: json['name'] as String,
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      country: json['country'] as String? ?? '',
      played: json['played'] as int? ?? 0,
      lost: json['lost'] as int? ?? 0,
      won: json['won'] as int? ?? 0,
      draws: json['draws'] as int? ?? 0,
      points: json['points'] as int? ?? 0,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'country': instance.country,
      'players': instance.players,
      'played': instance.played,
      'lost': instance.lost,
      'won': instance.won,
      'draws': instance.draws,
      'points': instance.points,
    };
