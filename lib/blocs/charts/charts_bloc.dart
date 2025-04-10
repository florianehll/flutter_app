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
    print('Début de la requête getTopSingles');
    final response = await _audioDbService.getTopSingles();
    print('Réponse reçue: ${response.trending != null ? '${response.trending!.length} résultats' : 'null'}');
    
    if (response.trending == null || response.trending!.isEmpty) {
      print('Aucun résultat de singles trouvé');
      emit(state.copyWith(
        singlesStatus: ChartsStatus.failure,
        singlesError: 'Aucun single trouvé',
      ));
      return;
    }
    
    // Afficher les premiers éléments pour déboguer
    if (response.trending!.isNotEmpty) {
      print('Premier élément: ${response.trending![0].toJson()}');
    }
    
    emit(state.copyWith(
      singlesStatus: ChartsStatus.success,
      singles: response.trending,
    ));
    print('Singles chargés avec succès');
  } catch (e, stackTrace) {
    print('Erreur détaillée lors du chargement des singles: $e');
    print('Stack trace: $stackTrace');
    emit(state.copyWith(
      singlesStatus: ChartsStatus.failure,
      singlesError: 'Erreur: ${e.toString()}',
    ));
  }
}

  Future<void> _onLoadTopAlbums(
    LoadTopAlbums event,
    Emitter<ChartsState> emit,
  ) async {
    emit(state.copyWith(albumsStatus: ChartsStatus.loading));
    try {
      print('Début de la requête getTopAlbums');
      final response = await _audioDbService.getTopAlbums();
      print('Réponse reçue: ${response.trending != null ? '${response.trending!.length} résultats' : 'null'}');
      
      if (response.trending == null) {
        print('Aucun résultat d\'albums trouvé');
        emit(state.copyWith(
          albumsStatus: ChartsStatus.failure,
          albumsError: 'Données non disponibles',
        ));
        return;
      }

      // Afficher les premiers éléments pour déboguer
      if (response.trending!.isNotEmpty) {
        print('Premier élément: ${response.trending![0].toJson()}');
      }
      
      emit(state.copyWith(
        albumsStatus: ChartsStatus.success,
        albums: response.trending,
      ));
      print('Albums chargés avec succès');
    } catch (e) {
      print('Erreur détaillée lors du chargement des albums: $e');
      emit(state.copyWith(
        albumsStatus: ChartsStatus.failure,
        albumsError: 'Erreur lors du chargement des albums',
      ));
    }
  }
}