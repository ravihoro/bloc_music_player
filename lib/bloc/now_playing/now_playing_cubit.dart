import 'dart:async';

import 'package:meta/meta.dart';
import 'package:just_audio/just_audio.dart';
import '../../model/song.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final AudioPlayer audioPlayer;

  NowPlayingCubit({@required this.audioPlayer}) : super(NowPlayingState());

  void updateSliderValue(double value) {
    emit(state.copyWith(sliderValue: value));
  }

  void play({Song song, List<Song> songs}) async {
    if (state.currentSong != song) audioPlayer.setUrl(song.uri);
    audioPlayer.play();
    if (state.currentSong == song) {
      emit(state.copyWith(playing: true));
    } else if (song != null && songs != null) {
      emit(state.copyWith(
          playing: true, song: song, songs: songs, sliderValue: 0.0));
    } else if (song != null) {
      emit(state.copyWith(playing: true, song: song, sliderValue: 0.0));
    }
  }

  void pause() async {
    await audioPlayer.pause();
    emit(state.copyWith(playing: false));
  }

  void next() async {
    int index = state.currentSongsList.indexOf(state.currentSong);
    int length = state.currentSongsList.length;
    index++;
    if (index >= length) {
      index = 0;
    }
    play(song: state.currentSongsList[index]);
  }

  void prev() async {
    int index = state.currentSongsList.indexOf(state.currentSong);
    int length = state.currentSongsList.length;
    index--;
    if (index < 0) {
      index = length - 1;
    }
    play(song: state.currentSongsList[index]);
  }
}
