part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchQueryChanged extends SearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class SearchArtists extends SearchEvent {
  final String query;

  const SearchArtists(this.query);

  @override
  List<Object> get props => [query];
}

class SearchAlbums extends SearchEvent {
  final String query;

  const SearchAlbums(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSearch extends SearchEvent {
  const ClearSearch();
}