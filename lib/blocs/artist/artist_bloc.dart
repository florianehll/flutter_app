import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../api/models/artist.dart';
import '../../api/models/album.dart';
import '../../api/services/audio_db_service.dart';

part 'artist_event.dart';
part 'artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final AudioDbService _audioDbService;
  
  ArtistBloc({required AudioDbService audioDbService}) 
      : _audioDbService = audioDbService,
        super(ArtistInitial()) {
    on<LoadArtistDetails>(_onLoadArtistDetails);
    on<LoadArtistAlbums>(_onLoadArtistAlbums);
  }
  
  Future<void> _onLoadArtistDetails(
    LoadArtistDetails event,
    Emitter<ArtistState> emit,
  ) async {
    emit(ArtistLoading());
    try {
      final response = await _audioDbService.getArtistDetails(
        artistId: event.artistId,
      );
      
      if (response.artists == null || response.artists!.isEmpty) {
        emit(ArtistError('Artiste non trouvé'));
        return;
      }
      
      emit(ArtistLoaded(response.artists!.first));
    } catch (e) {
      emit(ArtistError('Erreur lors du chargement des détails de l\'artiste'));
    }
  }
  
  Future<void> _onLoadArtistAlbums(
    LoadArtistAlbums event,
    Emitter<ArtistState> emit,
  ) async {
    try {
      if (state is ArtistLoaded) {
        final currentState = state as ArtistLoaded;
        emit(ArtistLoaded(currentState.artist, isLoadingAlbums: true));
        
        final response = await _audioDbService.getAlbumsByArtist(
          artistId: event.artistId,
        );
        
        emit(ArtistLoaded(
          currentState.artist,
          albums: response.albums ?? [],
          isLoadingAlbums: false,
        ));
      }
    } catch (e) {
      if (state is ArtistLoaded) {
        final currentState = state as ArtistLoaded;
        emit(ArtistLoaded(
          currentState.artist,
          albums: currentState.albums,
          isLoadingAlbums: false,
          albumsError: 'Erreur lors du chargement des albums',
        ));
      }
    }
  }
}