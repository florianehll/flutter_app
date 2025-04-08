part of 'album_bloc.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class LoadAlbumDetails extends AlbumEvent {
  final String albumId;

  const LoadAlbumDetails(this.albumId);

  @override
  List<Object> get props => [albumId];
}

class LoadAlbumTracks extends AlbumEvent {
  final String albumId;

  const LoadAlbumTracks(this.albumId);

  @override
  List<Object> get props => [albumId];
}