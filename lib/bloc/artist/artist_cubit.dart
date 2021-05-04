import '../../services/database_helper.dart';
import '../../model/song.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'artist_state.dart';

class ArtistCubit extends Cubit<ArtistState> {
  ArtistCubit(this.databaseHelper) : super(InitialArtistState());
  DatabaseHelper databaseHelper;

  void fetchArtistSongs({@required String id}) async {
    emit(LoadingArtistState());
    try {
      List<Song> songs = await databaseHelper.fetchArtistById(id);
      emit(LoadedArtistState(artistSongs: songs));
    } catch (e) {
      emit(FailedArtistState(exception: e));
    }
  }
}
