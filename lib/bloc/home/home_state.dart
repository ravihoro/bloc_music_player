part of './home_cubit.dart';

abstract class HomeState {}

class InitialState extends HomeState {}

class LoadingSongsState extends HomeState {}

class LoadedSongsState extends HomeState {
  final List<Song> songs;
  final List<Song> albums;
  final List<Song> artists;
  final List<Song> favorites;

  LoadedSongsState({this.songs, this.albums, this.artists, this.favorites});
}

class FailedSongsState extends HomeState {
  final Exception exception;

  FailedSongsState({this.exception});
}
