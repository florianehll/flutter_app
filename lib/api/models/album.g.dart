// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      id: json['idAlbum'] as String?,
      artistId: json['idArtist'] as String?,
      name: json['strAlbum'] as String?,
      artistName: json['strArtist'] as String?,
      yearReleased: json['intYearReleased'] as String?,
      genre: json['strGenre'] as String?,
      style: json['strStyle'] as String?,
      descriptionEn: json['strDescriptionEN'] as String?,
      descriptionFr: json['strDescriptionFR'] as String?,
      descriptionDe: json['strDescriptionDE'] as String?,
      descriptionEs: json['strDescriptionES'] as String?,
      descriptionIt: json['strDescriptionIT'] as String?,
      thumbUrl: json['strAlbumThumb'] as String?,
      cdArtUrl: json['strAlbumCDart'] as String?,
      spineUrl: json['strAlbumSpine'] as String?,
      case3DUrl: json['strAlbum3DCase'] as String?,
      flat3DUrl: json['strAlbum3DFlat'] as String?,
      face3DUrl: json['strAlbum3DFace'] as String?,
      thumb3DUrl: json['strAlbum3DThumb'] as String?,
      score: json['intScore'] as String?,
      scoreVotes: json['intScoreVotes'] as String?,
      mood: json['strMood'] as String?,
      theme: json['strTheme'] as String?,
      speed: json['strSpeed'] as String?,
      sales: json['intSales'] as String?,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'idAlbum': instance.id,
      'idArtist': instance.artistId,
      'strAlbum': instance.name,
      'strArtist': instance.artistName,
      'intYearReleased': instance.yearReleased,
      'strGenre': instance.genre,
      'strStyle': instance.style,
      'strDescriptionEN': instance.descriptionEn,
      'strDescriptionFR': instance.descriptionFr,
      'strDescriptionDE': instance.descriptionDe,
      'strDescriptionES': instance.descriptionEs,
      'strDescriptionIT': instance.descriptionIt,
      'strAlbumThumb': instance.thumbUrl,
      'strAlbumCDart': instance.cdArtUrl,
      'strAlbumSpine': instance.spineUrl,
      'strAlbum3DCase': instance.case3DUrl,
      'strAlbum3DFlat': instance.flat3DUrl,
      'strAlbum3DFace': instance.face3DUrl,
      'strAlbum3DThumb': instance.thumb3DUrl,
      'intScore': instance.score,
      'intScoreVotes': instance.scoreVotes,
      'strMood': instance.mood,
      'strTheme': instance.theme,
      'strSpeed': instance.speed,
      'intSales': instance.sales,
    };

AlbumResponse _$AlbumResponseFromJson(Map<String, dynamic> json) =>
    AlbumResponse(
      albums: (json['album'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumResponseToJson(AlbumResponse instance) =>
    <String, dynamic>{
      'album': instance.albums,
    };
