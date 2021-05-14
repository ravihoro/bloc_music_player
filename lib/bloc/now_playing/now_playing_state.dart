part of 'now_playing_cubit.dart';

class NowPlayingState {
  final bool playing;
  final bool shuffle;
  final Song currentSong;
  final double sliderValue;
  final List<Song> currentSongsList;
  final List<Song> prevList;
  final Pages page;
  final ScrollController scrollController;
  //final int index;
  //final List<Song> shuffledList;

  NowPlayingState({
    this.playing,
    this.currentSong,
    this.currentSongsList,
    this.sliderValue = 0.0,
    this.shuffle = false,
    this.prevList,
    this.page,
    this.scrollController,
    //this.index,
    //this.shuffledList,
  });

  NowPlayingState copyWith({
    bool playing,
    Song song,
    double sliderValue,
    List<Song> songs,
    bool shuffle,
    List<Song> prevList,
    Pages page,
    ScrollController scrollController,
  }) {
    // int index;
    // try {
    //   index = songs.indexOf(song) ??
    //       this.currentSongsList.indexOf(this.currentSong);
    // } catch (e) {
    //   print(e.toString());
    // }

    return NowPlayingState(
      playing: playing ?? this.playing,
      currentSong: song ?? this.currentSong,
      currentSongsList: songs ?? this.currentSongsList,
      sliderValue: sliderValue ?? this.sliderValue,
      shuffle: shuffle ?? this.shuffle,
      prevList: prevList ?? this.prevList,
      page: page ?? this.page,
      scrollController: scrollController ?? this.scrollController,
      //index: index,
      //index: currentSongsList.indexOf(currentSong) ??
      //this.currentSongsList.indexOf(this.currentSong),
      //shuffledList: shuffledList ?? this.shuffledList,
    );
  }
}
