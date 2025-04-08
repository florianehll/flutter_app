// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      id: json['idTrack'] as String?,
      albumId: json['idAlbum'] as String?,
      artistId: json['idArtist'] as String?,
      name: json['strTrack'] as String?,
      albumName: json['strAlbum'] as String?,
      artistName: json['strArtist'] as String?,
      trackNumber: json['intTrackNumber'] as String?,
      duration: json['intDuration'] as String?,
      thumbUrl: json['strTrackThumb'] as String?,
      musicVideoUrl: json['strMusicVid'] as String?,
      descriptionEn: json['strDescriptionEN'] as String?,
      totalPlays: json['intTotalPlays'] as String?,
      loved: json['intLoved'] as String?,
      score: json['intScore'] as String?,
      scoreVotes: json['intScoreVotes'] as String?,
      genre: json['strGenre'] as String?,
      mood: json['strMood'] as String?,
      style: json['strStyle'] as String?,
      theme: json['strTheme'] as String?,
      speed: json['strSpeed'] as String?,
    );

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'idTrack': instance.id,
      'idAlbum': instance.albumId,
      'idArtist': instance.artistId,
      'strTrack': instance.name,
      'strAlbum': instance.albumName,
      'strArtist': instance.artistName,
      'intTrackNumber': instance.trackNumber,
      'intDuration': instance.duration,
      'strTrackThumb': instance.thumbUrl,
      'strMusicVid': instance.musicVideoUrl,
      'strDescriptionEN': instance.descriptionEn,
      'intTotalPlays': instance.totalPlays,
      'intLoved': instance.loved,
      'intScore': instance.score,
      'intScoreVotes': instance.scoreVotes,
      'strGenre': instance.genre,
      'strMood': instance.mood,
      'strStyle': instance.style,
      'strTheme': instance.theme,
      'strSpeed': instance.speed,
    };

TrackResponse _$TrackResponseFromJson(Map<String, dynamic> json) =>
    TrackResponse(
      tracks: (json['track'] as List<dynamic>?)
          ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrackResponseToJson(TrackResponse instance) =>
    <String, dynamic>{
      'track': instance.tracks,
    };
