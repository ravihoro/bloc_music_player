import 'package:bloc_music_player/services/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/song.dart';
import 'package:meta/meta.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({@required this.databaseHelper})
      : super(FavoritesState(favorites: [], favoritesSet: Set()));

  final DatabaseHelper databaseHelper;

  void fetchFavorites() async {
    try {
      List<Song> favorites = await databaseHelper.fetchFavorites();
      Set<int> favoritesSet = Set();
      favorites.forEach((e) {
        favoritesSet.add(e.id);
      });
      emit(state.copyWith(
        favorites: favorites,
        favoritesSet: favoritesSet,
      ));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(favorites: [], favoritesSet: Set()));
    }
  }

  void addToFavorites(Song song) {
    if (!state.favoritesSet.contains(song.id)) {
      databaseHelper.addToFavorite(song.id);
      state.favorites.add(song);
      state.favoritesSet.add(song.id);
      state.favorites.sort((a, b) => a.title.compareTo(b.title));
      emit(state.copyWith(
        favorites: state.favorites,
        favoritesSet: state.favoritesSet,
      ));
    }
  }

  void removeFromFavorites(Song song) {
    if (state.favoritesSet.contains(song.id)) {
      databaseHelper.removeFromFavorite(song.id);
      state.favorites.remove(song);
      state.favoritesSet.remove(song.id);
      state.favorites.sort((a, b) => a.title.compareTo(b.title));
      emit(state.copyWith(
        favorites: state.favorites,
        favoritesSet: state.favoritesSet,
      ));
    }
  }
}
