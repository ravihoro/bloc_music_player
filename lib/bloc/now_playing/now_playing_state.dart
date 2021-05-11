part of 'now_playing_cubit.dart';

class NowPlayingState {
  final bool playing;
  final bool shuffle;
  final Song currentSong;
  final double sliderValue;
  final List<Song> currentSongsList;
  final List<Song> prevList;
  //final List<Song> shuffledList;

  NowPlayingState({
    this.playing,
    this.currentSong,
    this.currentSongsList,
    this.sliderValue = 0.0,
    this.shuffle = false,
    this.prevList,
    //this.shuffledList,
  });

  NowPlayingState copyWith({
    bool playing,
    Song song,
    double sliderValue,
    List<Song> songs,
    bool shuffle,
    List<Song> prevList,
  }) {
    return NowPlayingState(
      playing: playing ?? this.playing,
      currentSong: song ?? this.currentSong,
      currentSongsList: songs ?? this.currentSongsList,
      sliderValue: sliderValue ?? this.sliderValue,
      shuffle: shuffle ?? this.shuffle,
      prevList: prevList ?? this.prevList,
      //shuffledList: shuffledList ?? this.shuffledList,
    );
  }
}
