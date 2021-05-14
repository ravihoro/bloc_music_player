part of 'favorites_cubit.dart';

class FavoritesState {
  final List<Song> favorites;
  final Set<int> favoritesSet;

  FavoritesState({
    @required this.favorites,
    @required this.favoritesSet,
  });

  FavoritesState copyWith({List<Song> favorites, Set<int> favoritesSet}) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      favoritesSet: favoritesSet ?? this.favoritesSet,
    );
  }
}

// abstract class FavoritesState {}

// class InitialFavoritesState extends FavoritesState {}

// class LoadingFavoritesState extends FavoritesState {}

// class LoadedFavoritesState extends FavoritesState {
//   final List<Song> favorites;
//   final Set<int> favoritesSet;

//   LoadedFavoritesState({
//     @required this.favorites,
//     @required this.favoritesSet,
//   });
// }

// class FailedFavoritesState extends FavoritesState {
//   final Exception exception;

//   FailedFavoritesState({this.exception});
// }
