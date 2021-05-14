import 'package:bloc_music_player/enum/pages.dart';
import 'package:bloc_music_player/services/database_helper.dart';
import 'package:meta/meta.dart';
import 'package:just_audio/just_audio.dart';
import '../../model/song.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final AudioPlayer audioPlayer;
  final DatabaseHelper databaseHelper;

  NowPlayingCubit({@required this.audioPlayer, @required this.databaseHelper})
      : super(NowPlayingState());

  void updateSliderValue(double value) {
    emit(state.copyWith(sliderValue: value));
  }

  void shuffle() {
    //emit(state.copyWith(shuffle: !state.shuffle));
    if (state.shuffle) {
      emit(state.copyWith(
        shuffle: false,
        songs: state.prevList,
        scrollController: ScrollController(
          initialScrollOffset: 65.0 * state.prevList.indexOf(state.currentSong),
        ),
      ));
    } else {
      List<Song> songs = [...state.currentSongsList];
      songs.shuffle();

      emit(state.copyWith(
        scrollController: ScrollController(
          initialScrollOffset: 65.0 * songs.indexOf(state.currentSong),
        ),
        songs: songs,
        shuffle: true,
        prevList: state.currentSongsList,
      ));
    }
  }

  void play({
    @required Song song,
    List<Song> songs,
    Pages page,
  }) {
    if (state.currentSong != song || state.page != page) {
      audioPlayer.setUrl(song.uri);
    }

    audioPlayer.play();

    if (state.currentSong != null &&
        state.currentSong.id == song.id &&
        state.page == page) {
      //song and page are same
      print("1 called");
      emit(state.copyWith(playing: true));
    } else if (state.page != page) {
      //page is different
      print("2 called");
      if (songs == null) songs = state.currentSongsList;
      print(page);
      print(page == Pages.NowPlaying);
      print(state.shuffle);
      emit(state.copyWith(
        song: song,
        songs: songs,
        shuffle: page == Pages.NowPlaying
            ? state.shuffle
                ? true
                : false
            : false,
        page: page,
        playing: true,
        sliderValue: 0.0,
        scrollController: ScrollController(
          initialScrollOffset: 65.0 * songs.indexOf(song),
        ),
      ));
    } else if (state.page == page && state.currentSong.id != song.id) {
      //page is same but song is different
      print("3 called");
      emit(state.copyWith(
        song: song,
        playing: true,
        sliderValue: 0.0,
        scrollController: ScrollController(
          initialScrollOffset: 65.0 * state.currentSongsList.indexOf(song),
        ),
      ));
    }

    // if (state.currentSong.id == song.id &&
    //     state.page == page &&
    //     songs == null) {
    //   print("1 next called");
    //   emit(
    //     state.copyWith(
    //       playing: true,
    //       page: page,
    //     ),
    //   );
    // } else if (song != null && songs != null) {
    //   if (state.prevList != null &&
    //       (state.prevList[0].title != songs[0].title ||
    //           state.prevList[0].album != songs[0].album ||
    //           state.prevList[0].artist != songs[0].artist)) {
    //     print("2 next called");
    //     emit(
    //       state.copyWith(
    //         playing: true,
    //         song: song,
    //         songs: songs,
    //         sliderValue: 0.0,
    //         shuffle: false,
    //         page: page,
    //       ),
    //     );
    //   } else {
    //     print("3 next called");
    //     emit(
    //       state.copyWith(
    //         playing: true,
    //         song: song,
    //         songs: songs,
    //         sliderValue: 0.0,
    //         page: page,
    //       ),
    //     );
    //   }
    // } else if (song != null) {
    //   print("4 next called");
    //   emit(
    //     state.copyWith(
    //       playing: true,
    //       song: song,
    //       sliderValue: 0.0,
    //       page: page,
    //     ),
    //   );
    // } else {
    //   print("5 next called");
    //   print("Coming here");
    // }
  }

  void stop() async {
    if (state.page == Pages.Favorites) {
      await audioPlayer.pause();
      emit(state.copyWith(playing: false, song: null, songs: []));
    }
  }

  void pause() async {
    await audioPlayer.pause();
    emit(state.copyWith(playing: false));
  }

  void next() {
    int index = state.currentSongsList.indexOf(state.currentSong);
    int length = state.currentSongsList.length;
    index++;
    if (index >= length) {
      index = 0;
    }
    play(
      song: state.currentSongsList[index],
      // songs: state.currentSongsList,
      page: Pages.NowPlaying,
    );
  }

  void prev() {
    int index = state.currentSongsList.indexOf(state.currentSong);
    int length = state.currentSongsList.length;
    index--;
    if (index < 0) {
      index = length - 1;
    }
    play(
      song: state.currentSongsList[index],
      // songs: state.currentSongsList,
      page: Pages.NowPlaying,
    );
  }

  void updateCurrentSongsList(List<Song> songs) {
    emit(state.copyWith(songs: songs));
  }

  // void setFavorite() async {
  //   bool value = await databaseHelper.setFavorite(state.currentSong);
  //   if (value) {
  //     emit(state.copyWith());
  //   } else {}
  // }
}
