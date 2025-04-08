import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist extends Equatable {
  @JsonKey(name: 'idArtist')
  final String? id;
  
  @JsonKey(name: 'strArtist')
  final String? name;
  
  @JsonKey(name: 'strGenre')
  final String? genre;
  
  @JsonKey(name: 'strStyle')
  final String? style;
  
  @JsonKey(name: 'strCountry')
  final String? country;
  
  @JsonKey(name: 'strBiographyEN')
  final String? biographyEn;
  
  @JsonKey(name: 'strBiographyFR')
  final String? biographyFr;
  
  @JsonKey(name: 'strBiographyDE')
  final String? biographyDe;
  
  @JsonKey(name: 'strBiographyES')
  final String? biographyEs;
  
  @JsonKey(name: 'strBiographyIT')
  final String? biographyIt;
  
  @JsonKey(name: 'strArtistThumb')
  final String? thumbUrl;
  
  @JsonKey(name: 'strArtistLogo')
  final String? logoUrl;
  
  @JsonKey(name: 'strArtistBanner')
  final String? bannerUrl;
  
  @JsonKey(name: 'strArtistFanart')
  final String? fanartUrl;
  
  @JsonKey(name: 'strArtistFanart2')
  final String? fanart2Url;
  
  @JsonKey(name: 'strArtistFanart3')
  final String? fanart3Url;
  
  @JsonKey(name: 'strWebsite')
  final String? website;
  
  @JsonKey(name: 'strFacebook')
  final String? facebook;
  
  @JsonKey(name: 'strTwitter')
  final String? twitter;
  
  @JsonKey(name: 'strInstagram')
  final String? instagram;
  
  @JsonKey(name: 'intFormedYear')
  final String? formedYear;
  
  @JsonKey(name: 'strMood')
  final String? mood;
  
  const Artist({
    this.id,
    this.name,
    this.genre,
    this.style,
    this.country,
    this.biographyEn,
    this.biographyFr,
    this.biographyDe,
    this.biographyEs,
    this.biographyIt,
    this.thumbUrl,
    this.logoUrl,
    this.bannerUrl,
    this.fanartUrl,
    this.fanart2Url,
    this.fanart3Url,
    this.website,
    this.facebook,
    this.twitter,
    this.instagram,
    this.formedYear,
    this.mood,
  });
  
  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
  
  @override
  List<Object?> get props => [
    id,
    name,
    genre,
    style,
    country,
    thumbUrl,
    logoUrl,
  ];
  
  String getLocalizedBiography(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return biographyFr ?? biographyEn ?? '';
      case 'de':
        return biographyDe ?? biographyEn ?? '';
      case 'es':
        return biographyEs ?? biographyEn ?? '';
      case 'it':
        return biographyIt ?? biographyEn ?? '';
      default:
        return biographyEn ?? '';
    }
  }
}

@JsonSerializable()
class ArtistResponse {
  @JsonKey(name: 'artists')
  final List<Artist>? artists;
  
  ArtistResponse({this.artists});
  
  factory ArtistResponse.fromJson(Map<String, dynamic> json) => 
      _$ArtistResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$ArtistResponseToJson(this);
}