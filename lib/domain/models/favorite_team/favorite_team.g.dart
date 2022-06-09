// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteTeam _$FavoriteTeamFromJson(Map<String, dynamic> json) => FavoriteTeam(
      title: json['title'] as String,
      players: (json['players'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: (json['image'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$FavoriteTeamToJson(FavoriteTeam instance) =>
    <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
      'players': instance.players.map((e) => e.toJson()).toList(),
    };
