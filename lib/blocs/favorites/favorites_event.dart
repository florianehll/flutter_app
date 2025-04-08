part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}

class AddFavoriteArtist extends FavoritesEvent {
  final Artist artist;

  const AddFavoriteArtist(this.artist);

  @override
  List<Object> get props => [artist];
}

class RemoveFavoriteArtist extends FavoritesEvent {
  final String artistId;

  const RemoveFavoriteArtist(this.artistId);

  @override
  List<Object> get props => [artistId];
}

class AddFavoriteAlbum extends FavoritesEvent {
  final Album album;

  const AddFavoriteAlbum(this.album);

  @override
  List<Object> get props => [album];
}

class RemoveFavoriteAlbum extends FavoritesEvent {
  final String albumId;

  const RemoveFavoriteAlbum(this.albumId);

  @override
  List<Object> get props => [albumId];
}