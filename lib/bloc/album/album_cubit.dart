import '../../services/database_helper.dart';
import '../../model/song.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit(this.databaseHelper) : super(InitialAlbumState());
  DatabaseHelper databaseHelper;

  void fetchAlbumSongs({@required String id}) async {
    emit(LoadingAlbumState());
    try {
      List<Song> songs = await databaseHelper.fetchAlbumById(id);
      emit(LoadedAlbumState(albumSongs: songs));
    } catch (e) {
      emit(FailedAlbumState(exception: e));
    }
  }
}
