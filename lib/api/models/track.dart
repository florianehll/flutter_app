import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'track.g.dart';

@JsonSerializable()
class Track extends Equatable {
  @JsonKey(name: 'idTrack')
  final String? id;
  
  @JsonKey(name: 'idAlbum')
  final String? albumId;
  
  @JsonKey(name: 'idArtist')
  final String? artistId;
  
  @JsonKey(name: 'strTrack')
  final String? name;
  
  @JsonKey(name: 'strAlbum')
  final String? albumName;
  
  @JsonKey(name: 'strArtist')
  final String? artistName;
  
  @JsonKey(name: 'intTrackNumber')
  final String? trackNumber;
  
  @JsonKey(name: 'intDuration')
  final String? duration;
  
  @JsonKey(name: 'strTrackThumb')
  final String? thumbUrl;
  
  @JsonKey(name: 'strMusicVid')
  final String? musicVideoUrl;
  
  @JsonKey(name: 'strDescriptionEN')
  final String? descriptionEn;
  
  @JsonKey(name: 'intTotalPlays')
  final String? totalPlays;
  
  @JsonKey(name: 'intLoved')
  final String? loved;
  
  @JsonKey(name: 'intScore')
  final String? score;
  
  @JsonKey(name: 'intScoreVotes')
  final String? scoreVotes;
  
  @JsonKey(name: 'strGenre')
  final String? genre;
  
  @JsonKey(name: 'strMood')
  final String? mood;
  
  @JsonKey(name: 'strStyle')
  final String? style;
  
  @JsonKey(name: 'strTheme')
  final String? theme;
  
  @JsonKey(name: 'strSpeed')
  final String? speed;
  
  const Track({
    this.id,
    this.albumId,
    this.artistId,
    this.name,
    this.albumName,
    this.artistName,
    this.trackNumber,
    this.duration,
    this.thumbUrl,
    this.musicVideoUrl,
    this.descriptionEn,
    this.totalPlays,
    this.loved,
    this.score,
    this.scoreVotes,
    this.genre,
    this.mood,
    this.style,
    this.theme,
    this.speed,
  });
  
  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  
  Map<String, dynamic> toJson() => _$TrackToJson(this);
  
  @override
  List<Object?> get props => [
    id,
    albumId,
    artistId,
    name,
    trackNumber,
  ];
}

@JsonSerializable()
class TrackResponse {
  @JsonKey(name: 'track')
  final List<Track>? tracks;
  
  TrackResponse({this.tracks});
  
  factory TrackResponse.fromJson(Map<String, dynamic> json) => 
      _$TrackResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$TrackResponseToJson(this);
}