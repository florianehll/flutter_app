part of 'artist_bloc.dart';

abstract class ArtistState extends Equatable {
  const ArtistState();
  
  @override
  List<Object?> get props => [];
}

class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}

class ArtistLoaded extends ArtistState {
  final Artist artist;
  final List<Album> albums;
  final bool isLoadingAlbums;
  final String? albumsError;

  const ArtistLoaded(
    this.artist, {
    this.albums = const [],
    this.isLoadingAlbums = false,
    this.albumsError,
  });

  @override
  List<Object?> get props => [artist, albums, isLoadingAlbums, albumsError];
}

class ArtistError extends ArtistState {
  final String message;

  const ArtistError(this.message);

  @override
  List<Object> get props => [message];
}