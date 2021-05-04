import 'dart:io';
import '../model/song.dart';

dynamic getImage(Song song) {
  return song.albumArtwork == null
      ? null
      : File.fromUri(Uri.parse(song.albumArtwork));
}
