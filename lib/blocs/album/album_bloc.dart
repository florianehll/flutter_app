import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../api/models/album.dart';
import '../../api/models/track.dart';
import '../../api/services/audio_db_service.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AudioDbService _audioDbService;
  
  AlbumBloc({required AudioDbService audioDbService}) 
      : _audioDbService = audioDbService,
        super(AlbumInitial()) {
    on<LoadAlbumDetails>(_onLoadAlbumDetails);
    on<LoadAlbumTracks>(_onLoadAlbumTracks);
  }
  
  Future<void> _onLoadAlbumDetails(
    LoadAlbumDetails event,
    Emitter<AlbumState> emit,
  ) async {
    emit(AlbumLoading());
    try {
      final response = await _audioDbService.getAlbumDetails(
        albumId: event.albumId,
      );
      
      if (response.albums == null || response.albums!.isEmpty) {
        emit(AlbumError('Album non trouvé'));
        return;
      }
      
      emit(AlbumLoaded(response.albums!.first));
      add(LoadAlbumTracks(event.albumId));
    } catch (e) {
      emit(AlbumError('Erreur lors du chargement des détails de l\'album'));
    }
  }
  
  Future<void> _onLoadAlbumTracks(
    LoadAlbumTracks event,
    Emitter<AlbumState> emit,
  ) async {
    try {
      if (state is AlbumLoaded) {
        final currentState = state as AlbumLoaded;
        emit(AlbumLoaded(currentState.album, isLoadingTracks: true));
        
        final response = await _audioDbService.getTracksByAlbum(
          albumId: event.albumId,
        );
        
        emit(AlbumLoaded(
          currentState.album,
          tracks: response.tracks ?? [],
          isLoadingTracks: false,
        ));
      }
    } catch (e) {
      if (state is AlbumLoaded) {
        final currentState = state as AlbumLoaded;
        emit(AlbumLoaded(
          currentState.album,
          tracks: currentState.tracks,
          isLoadingTracks: false,
          tracksError: 'Erreur lors du chargement des titres',
        ));
      }
    }
  }
}