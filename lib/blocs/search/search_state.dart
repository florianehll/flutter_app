part of 'search_bloc.dart';

enum SearchStatus { initial, loading, success, failure }

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  final String? query;
  
  const SearchLoading({this.query});
  
  @override
  List<Object?> get props => [query];
}

class SearchResults extends SearchState {
  final String query;
  final List<Artist> artists;
  final SearchStatus artistsStatus;
  final String? artistsError;
  
  final List<Album> albums;
  final SearchStatus albumsStatus;
  final String? albumsError;

  const SearchResults({
    required this.query,
    this.artists = const [],
    required this.artistsStatus,
    this.artistsError,
    this.albums = const [],
    required this.albumsStatus,
    this.albumsError,
  });

  SearchResults copyWith({
    String? query,
    List<Artist>? artists,
    SearchStatus? artistsStatus,
    String? artistsError,
    List<Album>? albums,
    SearchStatus? albumsStatus,
    String? albumsError,
  }) {
    return SearchResults(
      query: query ?? this.query,
      artists: artists ?? this.artists,
      artistsStatus: artistsStatus ?? this.artistsStatus,
      artistsError: artistsError ?? this.artistsError,
      albums: albums ?? this.albums,
      albumsStatus: albumsStatus ?? this.albumsStatus,
      albumsError: albumsError ?? this.albumsError,
    );
  }

  @override
  List<Object?> get props => [
    query,
    artists,
    artistsStatus,
    artistsError,
    albums,
    albumsStatus,
    albumsError,
  ];
}