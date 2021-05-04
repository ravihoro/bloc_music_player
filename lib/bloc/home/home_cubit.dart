import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import '../../model/song.dart';
import '../../services/database_helper.dart';
import 'package:meta/meta.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({@required this.audioQuery, @required this.databaseHelper})
      : super(InitialState());
  final FlutterAudioQuery audioQuery;
  final DatabaseHelper databaseHelper;

  void loadSongs() async {
    emit(LoadingSongsState());
    try {
      await databaseHelper.database();
      int count = await databaseHelper.count();
      if (count == 0) {
        await loadDatabase();
      }
      List<Song> songs = await databaseHelper.fetchSongs();
      List<Song> albums = await databaseHelper.fetchAlbums();
      List<Song> artists = await databaseHelper.fetchArtists();
      emit(LoadedSongsState(songs: songs, albums: albums, artists: artists));
    } catch (e) {
      emit(FailedSongsState(exception: e));
    }
  }

  Future<void> loadDatabase() async {
    List<SongInfo> songInfoList = await audioQuery.getSongs();
    List<Song> songs = [];
    for (SongInfo songInfo in songInfoList) {
      Song song = Song();
      song = song.fromSongInfo(songInfo);
      songs.add(song);
    }
    for (Song song in songs) {
      await databaseHelper.insertSong(song);
    }
  }
}
