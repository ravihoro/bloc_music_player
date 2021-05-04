import 'package:flutter/material.dart';
import './custom_list_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home/home_cubit.dart';
import '../enum/pages.dart';

class SongSearch extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search song';

  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is LoadedSongsState) {
          return Container(
            color: Colors.grey[850],
            child: ListView.builder(
              itemCount: state.songs.length,
              itemBuilder: (context, index) {
                return state.songs[index].title
                        .toLowerCase()
                        .contains(query.toString().toLowerCase())
                    ? CustomListTile(
                        song: state.songs[index],
                        songs: [state.songs[index]],
                        page: Pages.Search,
                      )
                    : Container();
              },
            ),
          );
        }
        return Container(
          height: 0,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.grey[850],
    );
  }
}
