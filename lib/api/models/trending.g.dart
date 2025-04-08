// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingItem _$TrendingItemFromJson(Map<String, dynamic> json) => TrendingItem(
      trackId: json['idTrack'] as String?,
      albumId: json['idAlbum'] as String?,
      artistId: json['idArtist'] as String?,
      trackName: json['strTrack'] as String?,
      albumName: json['strAlbum'] as String?,
      artistName: json['strArtist'] as String?,
      trackThumbUrl: json['strTrackThumb'] as String?,
      albumThumbUrl: json['strAlbumThumb'] as String?,
      artistThumbUrl: json['strArtistThumb'] as String?,
      chartPlace: (json['intChartPlace'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TrendingItemToJson(TrendingItem instance) =>
    <String, dynamic>{
      'idTrack': instance.trackId,
      'idAlbum': instance.albumId,
      'idArtist': instance.artistId,
      'strTrack': instance.trackName,
      'strAlbum': instance.albumName,
      'strArtist': instance.artistName,
      'strTrackThumb': instance.trackThumbUrl,
      'strAlbumThumb': instance.albumThumbUrl,
      'strArtistThumb': instance.artistThumbUrl,
      'intChartPlace': instance.chartPlace,
    };

TrendingResponse _$TrendingResponseFromJson(Map<String, dynamic> json) =>
    TrendingResponse(
      trending: (json['trending'] as List<dynamic>?)
          ?.map((e) => TrendingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrendingResponseToJson(TrendingResponse instance) =>
    <String, dynamic>{
      'trending': instance.trending,
    };
