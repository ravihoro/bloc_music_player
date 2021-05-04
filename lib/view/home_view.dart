import 'package:bloc_music_player/widgets/custom_bottom_bar.dart';
import 'package:bloc_music_player/widgets/custom_list_tile.dart';
import 'package:bloc_music_player/widgets/song_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home/home_cubit.dart';
import '../model/song.dart';
import '../enum/pages.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is LoadingSongsState) {
          return Scaffold(
            backgroundColor: Colors.grey[850],
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is LoadedSongsState) {
          return _songsList(context, state.songs, state.albums, state.artists);
        } else if (state is FailedSongsState) {
          return Scaffold(
            backgroundColor: Colors.grey[850],
            body: Center(
              child: Text(
                'Error: ${state.exception.toString()}',
              ),
            ),
          );
        } else
          return Container();
      },
    );
  }

  Widget _songsList(BuildContext context, List<Song> songs, List<Song> albums,
      List<Song> artists) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          actions: [
            InkWell(
              child: Icon(
                Icons.search,
              ),
              onTap: () {
                showSearch(context: context, delegate: SongSearch());
              },
            ),
            SizedBox(
              width: 10,
            ),
          ],
          backgroundColor: Colors.grey[850],
          title: Text(
            'Music Player',
          ),
          bottom: TabBar(
            indicatorColor: Colors.amber,
            unselectedLabelColor: Colors.amber,
            tabs: [
              Tab(
                child: Text('Songs'),
              ),
              Tab(
                child: Text('Albums'),
              ),
              Tab(
                child: Text('Artists'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return CustomListTile(
                  song: songs[index],
                  page: Pages.Songs,
                  songs: songs,
                );
              },
            ),
            ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                return CustomListTile(
                  song: albums[index],
                  page: Pages.Albums,
                );
              },
            ),
            ListView.builder(
                itemCount: artists.length,
                itemBuilder: (context, index) {
                  return CustomListTile(
                    song: artists[index],
                    page: Pages.Artists,
                  );
                }),
          ],
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }
}
