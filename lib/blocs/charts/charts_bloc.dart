import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../api/models/trending.dart';
import '../../api/services/audio_db_service.dart';

part 'charts_event.dart';
part 'charts_state.dart';

class ChartsBloc extends Bloc<ChartsEvent, ChartsState> {
  final AudioDbService _audioDbService;
  
  ChartsBloc({required AudioDbService audioDbService}) 
      : _audioDbService = audioDbService,
        super(const ChartsState()) {
    on<LoadTopSingles>(_onLoadTopSingles);
    on<LoadTopAlbums>(_onLoadTopAlbums);
  }
  
  Future<void> _onLoadTopSingles(
    LoadTopSingles event,
    Emitter<ChartsState> emit,
  ) async {
    emit(state.copyWith(singlesStatus: ChartsStatus.loading));
    try {
      final response = await _audioDbService.getTopSingles();
      
      if (response.trending == null || response.trending!.isEmpty) {
        emit(state.copyWith(
          singlesStatus: ChartsStatus.failure,
          singlesError: 'Aucun single disponible actuellement',
        ));
        return;
      }
      
      emit(state.copyWith(
        singlesStatus: ChartsStatus.success,
        singles: response.trending,
      ));
    } catch (e) {
      print('Erreur lors du chargement des singles: $e');
      emit(state.copyWith(
        singlesStatus: ChartsStatus.failure,
        singlesError: 'Erreur lors du chargement des singles. Veuillez réessayer.',
      ));
    }
  }
  
  Future<void> _onLoadTopAlbums(
    LoadTopAlbums event,
    Emitter<ChartsState> emit,
  ) async {
    emit(state.copyWith(albumsStatus: ChartsStatus.loading));
    try {
      final response = await _audioDbService.getTopAlbums();
      
      if (response.trending == null || response.trending!.isEmpty) {
        emit(state.copyWith(
          albumsStatus: ChartsStatus.failure,
          albumsError: 'Aucun album disponible actuellement',
        ));
        return;
      }
      
      emit(state.copyWith(
        albumsStatus: ChartsStatus.success,
        albums: response.trending,
      ));
    } catch (e) {
      print('Erreur lors du chargement des albums: $e');
      emit(state.copyWith(
        albumsStatus: ChartsStatus.failure,
        albumsError: 'Erreur lors du chargement des albums. Veuillez réessayer.',
      ));
    }
  }
}