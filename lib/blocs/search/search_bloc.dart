import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../api/models/artist.dart';
import '../../api/models/album.dart';
import '../../api/services/audio_db_service.dart';
import 'dart:async';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AudioDbService _audioDbService;
  Timer? _debounce;
  
  SearchBloc({required AudioDbService audioDbService}) 
      : _audioDbService = audioDbService,
        super(SearchInitial()) {
    on<SearchArtists>(_onSearchArtists);
    on<SearchAlbums>(_onSearchAlbums);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<ClearSearch>(_onClearSearch);
  }
  
  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
  
  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) {
    final query = event.query;
    
    // Clear search if query is empty
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      add(SearchArtists(query));
      add(SearchAlbums(query));
    });
  }
  
  Future<void> _onSearchArtists(
    SearchArtists event,
    Emitter<SearchState> emit,
  ) async {
    try {
      if (state is SearchInitial) {
        emit(const SearchLoading());
      } else if (state is SearchResults) {
        final currentState = state as SearchResults;
        emit(currentState.copyWith(artistsStatus: SearchStatus.loading));
      }
      
      final response = await _audioDbService.searchArtist(
        artistName: event.query,
      );
      
      if (state is SearchLoading) {
        emit(SearchResults(
          query: event.query,
          artists: response.artists ?? [],
          artistsStatus: SearchStatus.success,
          albumsStatus: SearchStatus.initial,
        ));
      } else if (state is SearchResults) {
        final currentState = state as SearchResults;
        emit(currentState.copyWith(
          query: event.query,
          artists: response.artists ?? [],
          artistsStatus: SearchStatus.success,
        ));
      }
    } catch (e) {
      if (state is SearchLoading) {
        emit(SearchResults(
          query: event.query,
          artistsStatus: SearchStatus.failure,
          artistsError: 'Erreur lors de la recherche d\'artistes',
          albumsStatus: SearchStatus.initial,
        ));
      } else if (state is SearchResults) {
        final currentState = state as SearchResults;
        emit(currentState.copyWith(
          artistsStatus: SearchStatus.failure,
          artistsError: 'Erreur lors de la recherche d\'artistes',
        ));
      }
    }
  }
  
  Future<void> _onSearchAlbums(
    SearchAlbums event,
    Emitter<SearchState> emit,
  ) async {
    try {
      if (state is SearchResults) {
        final currentState = state as SearchResults;
        emit(currentState.copyWith(albumsStatus: SearchStatus.loading));
      }
      
      final response = await _audioDbService.searchAlbum(
        albumName: event.query,
      );
      
      if (state is SearchResults) {
        final currentState = state as SearchResults;
        emit(currentState.copyWith(
          albums: response.albums ?? [],
          albumsStatus: SearchStatus.success,
        ));
      }
    } catch (e) {
      if (state is SearchResults) {
        final currentState = state as SearchResults;
        emit(currentState.copyWith(
          albumsStatus: SearchStatus.failure,
          albumsError: 'Erreur lors de la recherche d\'albums',
        ));
      }
    }
  }
  
  void _onClearSearch(
    ClearSearch event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchInitial());
  }
}