import 'package:bloc_music_player/bloc/album/album_cubit.dart';
import 'package:bloc_music_player/bloc/artist/artist_cubit.dart';
import 'package:bloc_music_player/bloc/now_playing/now_playing_cubit.dart';
import 'package:bloc_music_player/view/album_detail_view.dart';
import 'package:bloc_music_player/view/artist_detail_view.dart';
import 'package:bloc_music_player/view/now_playing_view.dart';
import 'package:flutter/material.dart';
import '../utility/image_helper.dart';
import '../model/song.dart';
import '../enum/pages.dart';
import 'package:provider/provider.dart';

class CustomListTile extends StatelessWidget {
  @required
  final Pages page;
  final bool isPlaying;
  @required
  final Song song;
  final List<Song> songs;

  CustomListTile({this.page, this.song, this.songs, this.isPlaying = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: song.albumArtwork == null
              ? AssetImage("assets/music.jpg")
              : FileImage(getImage(song)),
        ),
        title: Text(
          page == Pages.Songs ||
                  page == Pages.AlbumDetails ||
                  page == Pages.ArtistDetails ||
                  page == Pages.NowPlaying ||
                  page == Pages.Favorites ||
                  page == Pages.Search
              ? song.title
              : page == Pages.Albums
                  ? song.album
                  : song.artist,
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        subtitle: Text(
          page == Pages.Songs ||
                  page == Pages.AlbumDetails ||
                  page == Pages.Albums ||
                  page == Pages.NowPlaying ||
                  page == Pages.Favorites ||
                  page == Pages.Search
              ? song.artist
              : song.album,
          style: TextStyle(color: Colors.white),
        ),
        trailing: isPlaying
            ? Icon(
                Icons.play_circle_outline,
                color: Colors.amber,
              )
            : Text(
                page == Pages.Songs ||
                        page == Pages.AlbumDetails ||
                        page == Pages.NowPlaying ||
                        page == Pages.Favorites
                    ? Duration(
                        milliseconds: int.parse(song.duration),
                      ).toString().substring(2, 7)
                    : "",
                style: TextStyle(color: Colors.white),
              ),
        onTap: () {
          if (page == Pages.Songs ||
              page == Pages.AlbumDetails ||
              page == Pages.ArtistDetails ||
              page == Pages.Search ||
              page == Pages.NowPlaying ||
              page == Pages.Favorites) {
            //print(songs.indexOf(song));
            Provider.of<NowPlayingCubit>(context, listen: false).play(
              song: song,
              songs: songs,
              page: page,
            );
            if (page == Pages.Search) {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NowPlayingView()));
            }
          } else if (page == Pages.Albums) {
            context.read<AlbumCubit>().fetchAlbumSongs(id: song.albumId);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AlbumDetailView()));
          } else if (page == Pages.Artists) {
            context.read<ArtistCubit>().fetchArtistSongs(id: song.artistId);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ArtistDetailView()));
          }
        },
      ),
    );
  }
}
