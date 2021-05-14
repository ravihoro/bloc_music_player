import 'package:bloc_music_player/bloc/favorites/favorites_cubit.dart';
import 'package:bloc_music_player/utility/image_helper.dart';
import 'package:bloc_music_player/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../enum/pages.dart';
import '../bloc/now_playing/now_playing_cubit.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class NowPlayingView extends StatelessWidget {
  // final ScrollController scrollController;

  // NowPlayingView() : scrollController = ScrollController(
  //   initialScrollOffset:
  // );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        // int index = state.currentSongsList.indexOf(state.currentSong);
        // scrollController = ScrollController(
        //   initialScrollOffset: 65.0 * index,
        //   //keepScrollOffset: false,
        // );
        //print("Current song is : ${state.currentSong}");
        print("new page being built");
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Now Playing',
              style: TextStyle(
                color: Colors.amber,
              ),
            ),
          ),
          backgroundColor: Colors.grey[850],
          body: state.currentSong == null || state.currentSongsList.length == 0
              ? _emptyNowPlaying()
              : SlidingUpPanel(
                  color: Colors.white,
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                  minHeight: MediaQuery.of(context).size.height * 0.035,
                  body: Column(
                    mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        state.currentSong.title,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 30,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        state.currentSong.artist,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.amber,
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: state.currentSong.albumArtwork != null
                                    ? FileImage(
                                        getImage(state.currentSong),
                                      )
                                    : AssetImage("assets/music.jpg"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: StreamBuilder<Duration>(
                          stream: context
                              .read<NowPlayingCubit>()
                              .audioPlayer
                              .durationStream,
                          builder: (context, snapshot) {
                            var duration = snapshot.data ?? Duration.zero;
                            return StreamBuilder(
                              stream: context
                                  .read<NowPlayingCubit>()
                                  .audioPlayer
                                  .positionStream,
                              builder: (context, snapshot) {
                                var position = snapshot.data ?? Duration.zero;
                                if (position > duration) {
                                  position = duration;
                                }
                                return Slider(
                                  min: 0.0,
                                  max: duration.inMilliseconds.toDouble(),
                                  activeColor: Colors.amber,
                                  value: state.sliderValue ??
                                      position.inMilliseconds.toDouble(),
                                  onChanged: (val) {
                                    if (val <
                                        duration.inMilliseconds.toDouble()) {
                                      context
                                          .read<NowPlayingCubit>()
                                          .updateSliderValue(val);
                                      context
                                          .read<NowPlayingCubit>()
                                          .audioPlayer
                                          .seek(
                                            Duration(
                                              milliseconds: val.round(),
                                            ),
                                          );
                                    }
                                  },
                                  onChangeEnd: (endVal) {
                                    context
                                        .read<NowPlayingCubit>()
                                        .updateSliderValue(null);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 65.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StreamBuilder(
                              stream: context
                                  .read<NowPlayingCubit>()
                                  .audioPlayer
                                  .positionStream,
                              builder: (context, snapshot) {
                                var position = snapshot.data ?? Duration.zero;
                                return Text(
                                  "${position.toString().substring(2, 7)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                            Text(
                              Duration(
                                      milliseconds:
                                          int.parse(state.currentSong.duration))
                                  .toString()
                                  .substring(2, 7),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.shuffle,
                                color:
                                    state.shuffle ? Colors.amber : Colors.white,
                              ),
                              onTap: () {
                                context.read<NowPlayingCubit>().shuffle();
                              },
                            ),
                            InkWell(
                              child: Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                                size: 30,
                              ),
                              onTap: () {
                                context.read<NowPlayingCubit>().prev();
                              },
                            ),
                            state.playing
                                ? IconButton(
                                    icon: Icon(
                                      Icons.pause,
                                      color: Colors.amber,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      context.read<NowPlayingCubit>().pause();
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.play_arrow,
                                      color: Colors.amber,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<NowPlayingCubit>()
                                          .play(song: state.currentSong);
                                    },
                                  ),
                            InkWell(
                              child: Icon(
                                Icons.skip_next,
                                color: Colors.white,
                                size: 30,
                              ),
                              onTap: () {
                                context.read<NowPlayingCubit>().next();
                              },
                            ),
                            BlocBuilder<FavoritesCubit, FavoritesState>(
                              builder: (context, favoritesState) {
                                return favoritesState.favoritesSet
                                        .contains(state.currentSong.id)
                                    ? InkWell(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.amber,
                                        ),
                                        onTap: () {
                                          context
                                              .read<FavoritesCubit>()
                                              .removeFromFavorites(
                                                  state.currentSong);
                                        },
                                      )
                                    : InkWell(
                                        child: Icon(
                                          Icons.favorite_outline,
                                          color: Colors.white,
                                        ),
                                        onTap: () {
                                          context
                                              .read<FavoritesCubit>()
                                              .addToFavorites(
                                                  state.currentSong);
                                        },
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //panel: BottomSongsList(),
                  panel: Column(
                    children: [
                      Container(
                        child: Icon(
                          Icons.menu_sharp,
                          size: 30,
                        ),
                        width: double.infinity,
                        color: Colors.amber,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.grey[850],
                          child: ListView.builder(
                            controller: state.scrollController,
                            itemCount: state.currentSongsList.length,
                            itemBuilder: (context, index) {
                              return CustomListTile(
                                songs: state.currentSongsList,
                                song: state.currentSongsList[index],
                                page: Pages.NowPlaying,
                                isPlaying: state.currentSong.id ==
                                    state.currentSongsList[index].id,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _emptyNowPlaying() {
    print("Empty called");
    return Container(
      color: Colors.grey[850],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.music_note,
              size: 50,
              color: Colors.amber,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'No Music Found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class BottomSongsList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NowPlayingCubit, NowPlayingState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             Container(
//               child: Icon(
//                 Icons.menu_sharp,
//                 size: 30,
//               ),
//               width: double.infinity,
//               color: Colors.amber,
//             ),
//             Expanded(
//               child: Container(
//                 color: Colors.grey[850],
//                 child: ListView.builder(
//                   controller: state.scrollController,
//                   itemCount: state.currentSongsList.length,
//                   itemBuilder: (context, index) {
//                     return CustomListTile(
//                       songs: state.currentSongsList,
//                       song: state.currentSongsList[index],
//                       page: Pages.NowPlaying,
//                       isPlaying: state.currentSong.id ==
//                           state.currentSongsList[index].id,
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
