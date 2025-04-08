part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();
  
  @override
  List<Object?> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final Album album;
  final List<Track> tracks;
  final bool isLoadingTracks;
  final String? tracksError;

  const AlbumLoaded(
    this.album, {
    this.tracks = const [],
    this.isLoadingTracks = false,
    this.tracksError,
  });

  @override
  List<Object?> get props => [album, tracks, isLoadingTracks, tracksError];
}

class AlbumError extends AlbumState {
  final String message;

  const AlbumError(this.message);

  @override
  List<Object> get props => [message];
}