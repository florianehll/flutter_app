import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'album.g.dart';

@JsonSerializable()
class Album extends Equatable {
  @JsonKey(name: 'idAlbum')
  final String? id;
  
  @JsonKey(name: 'idArtist')
  final String? artistId;
  
  @JsonKey(name: 'strAlbum')
  final String? name;
  
  @JsonKey(name: 'strArtist')
  final String? artistName;
  
  @JsonKey(name: 'intYearReleased')
  final String? yearReleased;
  
  @JsonKey(name: 'strGenre')
  final String? genre;
  
  @JsonKey(name: 'strStyle')
  final String? style;
  
  @JsonKey(name: 'strDescriptionEN')
  final String? descriptionEn;
  
  @JsonKey(name: 'strDescriptionFR')
  final String? descriptionFr;
  
  @JsonKey(name: 'strDescriptionDE')
  final String? descriptionDe;
  
  @JsonKey(name: 'strDescriptionES')
  final String? descriptionEs;
  
  @JsonKey(name: 'strDescriptionIT')
  final String? descriptionIt;
  
  @JsonKey(name: 'strAlbumThumb')
  final String? thumbUrl;
  
  @JsonKey(name: 'strAlbumCDart')
  final String? cdArtUrl;
  
  @JsonKey(name: 'strAlbumSpine')
  final String? spineUrl;
  
  @JsonKey(name: 'strAlbum3DCase')
  final String? case3DUrl;
  
  @JsonKey(name: 'strAlbum3DFlat')
  final String? flat3DUrl;
  
  @JsonKey(name: 'strAlbum3DFace')
  final String? face3DUrl;
  
  @JsonKey(name: 'strAlbum3DThumb')
  final String? thumb3DUrl;
  
  @JsonKey(name: 'intScore')
  final String? score;
  
  @JsonKey(name: 'intScoreVotes')
  final String? scoreVotes;
  
  @JsonKey(name: 'strMood')
  final String? mood;
  
  @JsonKey(name: 'strTheme')
  final String? theme;
  
  @JsonKey(name: 'strSpeed')
  final String? speed;
  
  @JsonKey(name: 'intSales')
  final String? sales;
  
  const Album({
    this.id,
    this.artistId,
    this.name,
    this.artistName,
    this.yearReleased,
    this.genre,
    this.style,
    this.descriptionEn,
    this.descriptionFr,
    this.descriptionDe,
    this.descriptionEs,
    this.descriptionIt,
    this.thumbUrl,
    this.cdArtUrl,
    this.spineUrl,
    this.case3DUrl,
    this.flat3DUrl,
    this.face3DUrl,
    this.thumb3DUrl,
    this.score,
    this.scoreVotes,
    this.mood,
    this.theme,
    this.speed,
    this.sales,
  });
  
  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
  
  @override
  List<Object?> get props => [
    id,
    artistId,
    name,
    artistName,
    yearReleased,
    thumbUrl,
  ];
  
  String getLocalizedDescription(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return descriptionFr ?? descriptionEn ?? '';
      case 'de':
        return descriptionDe ?? descriptionEn ?? '';
      case 'es':
        return descriptionEs ?? descriptionEn ?? '';
      case 'it':
        return descriptionIt ?? descriptionEn ?? '';
      default:
        return descriptionEn ?? '';
    }
  }
}

@JsonSerializable()
class AlbumResponse {
  @JsonKey(name: 'album')
  final List<Album>? albums;
  
  AlbumResponse({this.albums});
  
  factory AlbumResponse.fromJson(Map<String, dynamic> json) => 
      _$AlbumResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$AlbumResponseToJson(this);
}