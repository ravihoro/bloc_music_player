part of 'now_playing_cubit.dart';

class NowPlayingState {
  final bool playing;
  final Song currentSong;
  final double sliderValue;
  final List<Song> currentSongsList;

  NowPlayingState(
      {this.playing,
      this.currentSong,
      this.currentSongsList,
      this.sliderValue = 0.0});

  NowPlayingState copyWith({
    bool playing,
    Song song,
    double sliderValue,
    List<Song> songs,
  }) {
    return NowPlayingState(
      playing: playing ?? this.playing,
      currentSong: song ?? this.currentSong,
      currentSongsList: songs ?? this.currentSongsList,
      sliderValue: sliderValue ?? this.sliderValue,
    );
  }
}
