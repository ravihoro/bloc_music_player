import 'package:bloc_music_player/widgets/custom_bottom_bar.dart';
import 'package:bloc_music_player/widgets/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../enum/pages.dart';
import '../bloc/artist/artist_cubit.dart';

class ArtistDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistCubit, ArtistState>(
      builder: (context, state) {
        if (state is LoadingArtistState) {
          return Scaffold(
            backgroundColor: Colors.grey[850],
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is LoadedArtistState) {
          return Scaffold(
            backgroundColor: Colors.grey[850],
            body: DetailView(
              page: Pages.ArtistDetails,
              songs: state.artistSongs,
            ),
            bottomNavigationBar: CustomBottomBar(),
          );
        } else if (state is FailedArtistState) {
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
