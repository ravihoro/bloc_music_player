import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/now_playing/now_playing_cubit.dart';
import '../utility/image_helper.dart';
import '../view/now_playing_view.dart';

class CustomBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        return state.currentSong == null
            ? Container(
                height: 0,
              )
            : Container(
                height: 50,
                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: state.currentSong.albumArtwork == null
                            ? CircleAvatar(
                                backgroundImage: AssetImage(
                                  "assets/music.jpg",
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                  getImage(state.currentSong),
                                ),
                              ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NowPlayingView()));
                          },
                          child: Text(
                            state.currentSong.title,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.skip_previous,
                          ),
                        ),
                        onTap: () {
                          context.read<NowPlayingCubit>().prev();
                        },
                      ),
                      state.playing
                          ? InkWell(
                              child: Icon(Icons.pause),
                              onTap: () {
                                context.read<NowPlayingCubit>().pause();
                              },
                            )
                          : InkWell(
                              child: Icon(Icons.play_arrow),
                              onTap: () {
                                context
                                    .read<NowPlayingCubit>()
                                    .play(song: state.currentSong);
                              },
                            ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.skip_next,
                          ),
                        ),
                        onTap: () {
                          context.read<NowPlayingCubit>().next();
                        },
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
