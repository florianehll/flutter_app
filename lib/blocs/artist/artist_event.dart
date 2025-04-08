part of 'artist_bloc.dart';

abstract class ArtistEvent extends Equatable {
  const ArtistEvent();

  @override
  List<Object> get props => [];
}

class LoadArtistDetails extends ArtistEvent {
  final String artistId;

  const LoadArtistDetails(this.artistId);

  @override
  List<Object> get props => [artistId];
}

class LoadArtistAlbums extends ArtistEvent {
  final String artistId;

  const LoadArtistAlbums(this.artistId);

  @override
  List<Object> get props => [artistId];
}