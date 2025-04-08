import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/models/artist.dart';
import '../../api/models/album.dart';
import '../../config/constants.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final SharedPreferences _preferences;
  
  FavoritesBloc({required SharedPreferences preferences})
      : _preferences = preferences,
        super(const FavoritesState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavoriteArtist>(_onAddFavoriteArtist);
    on<RemoveFavoriteArtist>(_onRemoveFavoriteArtist);
    on<AddFavoriteAlbum>(_onAddFavoriteAlbum);
    on<RemoveFavoriteAlbum>(_onRemoveFavoriteAlbum);
  }
  
  void _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) {
    try {
      emit(state.copyWith(status: FavoritesStatus.loading));
      
      // Load favorite artists
      final artistsJson = _preferences.getStringList(AppConstants.favoriteArtistsKey) ?? [];
      final List<Artist> artists = artistsJson
          .map((json) => Artist.fromJson(jsonDecode(json)))
          .toList();
      
      emit(state.copyWith(
        status: FavoritesStatus.success,
        artists: artists,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.failure,
        error: 'Erreur lors du chargement des favoris',
      ));
    }
  }
  
  void _onAddFavoriteArtist(
    AddFavoriteArtist event,
    Emitter<FavoritesState> emit,
  ) {
    try {
      final List<Artist> updatedArtists = List.from(state.artists)
        ..add(event.artist);
      
      // Save to shared preferences
      final List<String> artistsJson = updatedArtists
          .map((artist) => jsonEncode(artist.toJson()))
          .toList();
      _preferences.setStringList(AppConstants.favoriteArtistsKey, artistsJson);
      
      emit(state.copyWith(artists: updatedArtists));
    } catch (e) {
      emit(state.copyWith(
        error: 'Erreur lors de l\'ajout aux favoris',
      ));
    }
  }
  
  void _onRemoveFavoriteArtist(
    RemoveFavoriteArtist event,
    Emitter<FavoritesState> emit,
  ) {
    try {
      final List<Artist> updatedArtists = List.from(state.artists)
        ..removeWhere((artist) => artist.id == event.artistId);
      
      // Save to shared preferences
      final List<String> artistsJson = updatedArtists
          .map((artist) => jsonEncode(artist.toJson()))
          .toList();
      _preferences.setStringList(AppConstants.favoriteArtistsKey, artistsJson);
      
      emit(state.copyWith(artists: updatedArtists));
    } catch (e) {
      emit(state.copyWith(
        error: 'Erreur lors de la suppression des favoris',
      ));
    }
  }
  
  void _onAddFavoriteAlbum(
    AddFavoriteAlbum event,
    Emitter<FavoritesState> emit,
  ) {
    // This feature is not required in the project but could be implemented similarly
  }
  
  void _onRemoveFavoriteAlbum(
    RemoveFavoriteAlbum event,
    Emitter<FavoritesState> emit,
  ) {
    // This feature is not required in the project but could be implemented similarly
  }
}