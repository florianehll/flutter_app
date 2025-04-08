// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      id: json['idArtist'] as String?,
      name: json['strArtist'] as String?,
      genre: json['strGenre'] as String?,
      style: json['strStyle'] as String?,
      country: json['strCountry'] as String?,
      biographyEn: json['strBiographyEN'] as String?,
      biographyFr: json['strBiographyFR'] as String?,
      biographyDe: json['strBiographyDE'] as String?,
      biographyEs: json['strBiographyES'] as String?,
      biographyIt: json['strBiographyIT'] as String?,
      thumbUrl: json['strArtistThumb'] as String?,
      logoUrl: json['strArtistLogo'] as String?,
      bannerUrl: json['strArtistBanner'] as String?,
      fanartUrl: json['strArtistFanart'] as String?,
      fanart2Url: json['strArtistFanart2'] as String?,
      fanart3Url: json['strArtistFanart3'] as String?,
      website: json['strWebsite'] as String?,
      facebook: json['strFacebook'] as String?,
      twitter: json['strTwitter'] as String?,
      instagram: json['strInstagram'] as String?,
      formedYear: json['intFormedYear'] as String?,
      mood: json['strMood'] as String?,
    );

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'idArtist': instance.id,
      'strArtist': instance.name,
      'strGenre': instance.genre,
      'strStyle': instance.style,
      'strCountry': instance.country,
      'strBiographyEN': instance.biographyEn,
      'strBiographyFR': instance.biographyFr,
      'strBiographyDE': instance.biographyDe,
      'strBiographyES': instance.biographyEs,
      'strBiographyIT': instance.biographyIt,
      'strArtistThumb': instance.thumbUrl,
      'strArtistLogo': instance.logoUrl,
      'strArtistBanner': instance.bannerUrl,
      'strArtistFanart': instance.fanartUrl,
      'strArtistFanart2': instance.fanart2Url,
      'strArtistFanart3': instance.fanart3Url,
      'strWebsite': instance.website,
      'strFacebook': instance.facebook,
      'strTwitter': instance.twitter,
      'strInstagram': instance.instagram,
      'intFormedYear': instance.formedYear,
      'strMood': instance.mood,
    };

ArtistResponse _$ArtistResponseFromJson(Map<String, dynamic> json) =>
    ArtistResponse(
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArtistResponseToJson(ArtistResponse instance) =>
    <String, dynamic>{
      'artists': instance.artists,
    };
