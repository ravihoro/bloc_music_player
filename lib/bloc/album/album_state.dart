part of 'album_cubit.dart';

abstract class AlbumState {}

class InitialAlbumState extends AlbumState {}

class LoadingAlbumState extends AlbumState {}

class LoadedAlbumState extends AlbumState {
  final List<Song> albumSongs;

  LoadedAlbumState({@required this.albumSongs});
}

class FailedAlbumState extends AlbumState {
  final Exception exception;

  FailedAlbumState({this.exception});
}
