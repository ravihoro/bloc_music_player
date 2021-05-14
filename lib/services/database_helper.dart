import '../model/song.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

class DatabaseHelper extends ChangeNotifier {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<void> database() async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
  }

  Future<Database> initializeDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "songs.db");
    var tempDb = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return tempDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''CREATE TABLE songs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      album TEXT,
      albumId TEXT,
      artist TEXT,
      artistId TEXT,
      year TEXT,
      duration TEXT,
      uri TEXT,
      albumArtwork TEXT,
      isFav INTEGER NOT NULL DEFAULT 0
    )''');
  }

  Future<int> count() async {
    int count = Sqflite.firstIntValue(
        await _database.rawQuery("SELECT COUNT(*) FROM songs"));
    return count;
  }

  Future<void> insertSong(Song song) async {
    await _database.insert("songs", song.toMap());
  }

  Future<List<Song>> fetchSongs() async {
    List<Map> result = await _database.query("songs", orderBy: "title");
    List<Song> songs = [];
    result.forEach((s) {
      Song song = Song.fromMap(s);
      songs.add(song);
    });
    return songs;
  }

  Future<List<Song>> fetchSongsByAlbums() async {
    List<Map> result =
        await _database.query("songs", orderBy: "album", groupBy: "album");
    List<Song> songs = [];
    result.forEach((s) {
      Song song = Song.fromMap(s);
      songs.add(song);
    });
    return songs;
  }

  Future<List<Song>> fetchAlbums() async {
    List<Map> result = await _database.query("songs",
        orderBy: "album", groupBy: "album", distinct: true);
    List<Song> songs = [];
    result.forEach((s) {
      Song song = Song.fromMap(s);
      songs.add(song);
    });
    return songs;
  }

  Future<List<Song>> fetchAlbumById(String id) async {
    List<Map> result = await _database.query("songs", where: "albumId == $id");
    List<Song> songs = [];
    result.forEach((s) {
      Song song = Song.fromMap(s);
      songs.add(song);
    });
    return songs;
  }

  Future<List<Song>> fetchFavorites() async {
    List<Map> result = await _database.query("songs", where: "isFav == 1");
    List<Song> songs = [];
    result.forEach((s) {
      Song song = Song.fromMap(s);
      songs.add(song);
    });
    return songs;
  }

  Future<List<Song>> fetchArtists() async {
    List<Map> result = await _database.query("songs",
        groupBy: "artist", orderBy: "artist", distinct: true);
    List<Song> songs = [];
    result.forEach((s) {
      Song song = Song.fromMap(s);
      songs.add(song);
    });
    return songs;
  }

  Future<List<Song>> fetchArtistById(String id) async {
    List<Map> result = await _database.query("songs", where: "artistId == $id");
    List<Song> songs = [];
    result.forEach((s) {
      Song song = Song.fromMap(s);
      songs.add(song);
    });
    return songs;
  }

  Future<Song> fetchSongById(int id) async {
    List<Map> result = await _database.query("songs", where: "id == $id");
    Song song = Song.fromMap(result.first);
    print(song.title);
    return song;
  }

  Future<bool> addToFavorite(int id) async {
    try {
      await _database.update("songs", {"isFav": 1}, where: "id == $id");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromFavorite(int id) async {
    try {
      await _database.update("songs", {"isFav": 0}, where: "id == $id");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setFavorite(Song song) async {
    int val = song.isFav;
    try {
      if (val == 0) {
        await _database.update("songs", {"isFav": 1},
            where: "title == ${song.title}");
      } else {
        await _database.update("songs", {"isFav": 0},
            where: "title == ${song.title}");
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
