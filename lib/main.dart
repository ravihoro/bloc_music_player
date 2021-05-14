import 'package:bloc_music_player/bloc/favorites/favorites_cubit.dart';
import 'package:bloc_music_player/bloc/home/home_cubit.dart';
import 'package:bloc_music_player/bloc/now_playing/now_playing_cubit.dart';
import 'package:bloc_music_player/services/database_helper.dart';
import 'package:bloc_music_player/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import './bloc/artist/artist_cubit.dart';
import './bloc/album/album_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseHelper databaseHelper = DatabaseHelper();

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(
            audioQuery: FlutterAudioQuery(),
            databaseHelper: databaseHelper,
          )..loadSongs(),
        ),
        BlocProvider<NowPlayingCubit>(
          create: (context) => NowPlayingCubit(
            audioPlayer: AudioPlayer(),
            databaseHelper: databaseHelper,
          ),
        ),
        BlocProvider<ArtistCubit>(
          create: (context) => ArtistCubit(databaseHelper),
        ),
        BlocProvider<AlbumCubit>(
          create: (context) => AlbumCubit(databaseHelper),
        ),
        BlocProvider<FavoritesCubit>(
          create: (context) =>
              FavoritesCubit(databaseHelper: databaseHelper)..fetchFavorites(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return StreamBuilder(
            stream: context
                .read<NowPlayingCubit>()
                .audioPlayer
                .processingStateStream,
            builder: (context, snapshot) {
              if (snapshot.data == ProcessingState.completed)
                context.read<NowPlayingCubit>().next();
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: HomeView(),
                title: 'Music Player',
              );
            },
          );
        },
      ),
    );
  }
}
