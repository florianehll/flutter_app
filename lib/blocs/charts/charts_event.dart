part of 'charts_bloc.dart';

abstract class ChartsEvent extends Equatable {
  const ChartsEvent();

  @override
  List<Object> get props => [];
}

class LoadTopSingles extends ChartsEvent {
  const LoadTopSingles();
}

class LoadTopAlbums extends ChartsEvent {
  const LoadTopAlbums();
}