part of 'artist_cubit.dart';

abstract class ArtistState {}

class InitialArtistState extends ArtistState {}

class LoadingArtistState extends ArtistState {}

class LoadedArtistState extends ArtistState {
  final List<Song> artistSongs;

  LoadedArtistState({@required this.artistSongs});
}

class FailedArtistState extends ArtistState {
  final Exception exception;

  FailedArtistState({this.exception});
}
