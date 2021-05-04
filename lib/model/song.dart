import 'package:flutter_audio_query/flutter_audio_query.dart';

class Song {
  final int id;
  final String title;
  final String album;
  final String albumId;
  final String artist;
  final String artistId;
  final String year;
  final String duration;
  final String uri;
  final String albumArtwork;
  final int isFav;

  Song({
    this.id,
    this.title,
    this.album,
    this.albumId,
    this.artist,
    this.artistId,
    this.year,
    this.duration,
    this.uri,
    this.albumArtwork,
    this.isFav,
  });

  Song fromSongInfo(SongInfo songInfo) {
    return Song(
      title: songInfo.title,
      album: songInfo.album,
      albumId: songInfo.albumId,
      artist: songInfo.artist,
      artistId: songInfo.artistId,
      year: songInfo.year,
      duration: songInfo.duration,
      uri: songInfo.uri,
      albumArtwork: songInfo.albumArtwork,
      isFav: 0,
    );
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    //map["id"] = this.id;
    map["title"] = this.title;
    map["artist"] = this.artist;
    map["artistId"] = this.artistId;
    map["album"] = this.album;
    map["albumId"] = this.albumId;
    map["year"] = this.year;
    map["duration"] = this.duration;
    map["uri"] = this.uri;
    map["albumArtwork"] = this.albumArtwork;
    map["isFav"] = this.isFav;
    return map;
  }

  Song fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'],
      title: map['title'],
      album: map['album'],
      albumId: map['albumId'],
      artist: map['artist'],
      artistId: map['artistId'],
      year: map['year'],
      duration: map['duration'],
      uri: map['uri'],
      albumArtwork: map['albumArtwork'],
      isFav: map['isFav'],
    );
  }

  List<Song> toList(List<Map<String, dynamic>> query) {
    List<Song> songs = [];
    for (Map map in query) {
      songs.add(fromMap(map));
    }
    return songs;
  }
}
