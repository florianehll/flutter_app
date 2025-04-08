part of 'charts_bloc.dart';

enum ChartsStatus { initial, loading, success, failure }

class ChartsState extends Equatable {
  final ChartsStatus singlesStatus;
  final List<TrendingItem>? singles;
  final String? singlesError;
  
  final ChartsStatus albumsStatus;
  final List<TrendingItem>? albums;
  final String? albumsError;

  const ChartsState({
    this.singlesStatus = ChartsStatus.initial,
    this.singles,
    this.singlesError,
    this.albumsStatus = ChartsStatus.initial,
    this.albums,
    this.albumsError,
  });

  ChartsState copyWith({
    ChartsStatus? singlesStatus,
    List<TrendingItem>? singles,
    String? singlesError,
    ChartsStatus? albumsStatus,
    List<TrendingItem>? albums,
    String? albumsError,
  }) {
    return ChartsState(
      singlesStatus: singlesStatus ?? this.singlesStatus,
      singles: singles ?? this.singles,
      singlesError: singlesError ?? this.singlesError,
      albumsStatus: albumsStatus ?? this.albumsStatus,
      albums: albums ?? this.albums,
      albumsError: albumsError ?? this.albumsError,
    );
  }

  @override
  List<Object?> get props => [
    singlesStatus,
    singles,
    singlesError,
    albumsStatus,
    albums,
    albumsError,
  ];
}