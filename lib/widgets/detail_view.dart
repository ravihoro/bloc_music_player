import 'package:flutter/material.dart';
import '../enum/pages.dart';
import '../model/song.dart';
import '../utility/image_helper.dart';
import 'custom_list_tile.dart';

class DetailView extends StatelessWidget {
  final Pages page;
  final List<Song> songs;

  DetailView({this.page, this.songs});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 1 / 3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: songs[0].albumArtwork != null
                  ? (FileImage(getImage(songs[0])))
                  : AssetImage("assets/music.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                song: songs[index],
                page: page,
                songs: songs,
              );
            },
          ),
        ),
      ],
    );
  }
}
