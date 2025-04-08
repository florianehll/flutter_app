part of 'favorites_bloc.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<Artist> artists;
  final List<Album> albums;
  final String? error;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.artists = const [],
    this.albums = const [],
    this.error,
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<Artist>? artists,
    List<Album>? albums,
    String? error,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      artists: artists ?? this.artists,
      albums: albums ?? this.albums,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, artists, albums, error];
  
  bool isArtistFavorite(String artistId) {
    return artists.any((artist) => artist.id == artistId);
  }
  
  bool isAlbumFavorite(String albumId) {
    return albums.any((album) => album.id == albumId);
  }
}