import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'trending.g.dart';

@JsonSerializable()
class TrendingItem extends Equatable {
  @JsonKey(name: 'idTrack')
  final String? trackId;
  
  @JsonKey(name: 'idAlbum')
  final String? albumId;
  
  @JsonKey(name: 'idArtist')
  final String? artistId;
  
  @JsonKey(name: 'strTrack')
  final String? trackName;
  
  @JsonKey(name: 'strAlbum')
  final String? albumName;
  
  @JsonKey(name: 'strArtist')
  final String? artistName;
  
  @JsonKey(name: 'strTrackThumb')
  final String? trackThumbUrl;
  
  @JsonKey(name: 'strAlbumThumb')
  final String? albumThumbUrl;
  
  @JsonKey(name: 'strArtistThumb')
  final String? artistThumbUrl;
  
  @JsonKey(name: 'intChartPlace')
  final int? chartPlace;
  
  const TrendingItem({
    this.trackId,
    this.albumId,
    this.artistId,
    this.trackName,
    this.albumName,
    this.artistName,
    this.trackThumbUrl,
    this.albumThumbUrl,
    this.artistThumbUrl,
    this.chartPlace,
  });
  
  factory TrendingItem.fromJson(Map<String, dynamic> json) => 
      _$TrendingItemFromJson(json);
      
  Map<String, dynamic> toJson() => _$TrendingItemToJson(this);
  
  @override
  List<Object?> get props => [
    trackId,
    albumId,
    artistId,
    trackName,
    albumName,
    artistName,
    chartPlace,
  ];
}

@JsonSerializable()
class TrendingResponse {
  @JsonKey(name: 'trending')
  final List<TrendingItem>? trending;
  
  TrendingResponse({this.trending});
  
  factory TrendingResponse.fromJson(Map<String, dynamic> json) => 
      _$TrendingResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$TrendingResponseToJson(this);
}