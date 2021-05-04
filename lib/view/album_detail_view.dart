import 'package:bloc_music_player/widgets/custom_bottom_bar.dart';
import 'package:bloc_music_player/widgets/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../enum/pages.dart';
import '../bloc/album/album_cubit.dart';

class AlbumDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumCubit, AlbumState>(
      builder: (context, state) {
        if (state is LoadingAlbumState) {
          return Scaffold(
            backgroundColor: Colors.grey[850],
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is LoadedAlbumState) {
          return Scaffold(
            backgroundColor: Colors.grey[850],
            body: DetailView(
              page: Pages.AlbumDetails,
              songs: state.albumSongs,
            ),
            bottomNavigationBar: CustomBottomBar(),
          );
        } else if (state is FailedAlbumState) {
          return Scaffold(
            backgroundColor: Colors.grey[850],
            body: Center(
              child: Text('Error: ${state.exception.toString()}'),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
