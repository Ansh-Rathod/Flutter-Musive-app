import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:spotify_clone/controllers/main_controller.dart';
import 'package:spotify_clone/models/song_model.dart';
import 'package:spotify_clone/models/user.dart';
import 'package:spotify_clone/screens/artist_profile/artist_profile.dart';
import 'package:spotify_clone/utils/loading.dart';

import 'botttom_sheet_widget.dart';

class HorizontalSongList extends StatelessWidget {
  final List<SongModel> songs;
  final MainController con;
  const HorizontalSongList({
    Key? key,
    required this.songs,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          ...songs
              .map(
                (song) => InkWell(
                  onTap: () {
                    con.playSong(
                        con.convertToAudio(songs), songs.indexOf(song));
                  },
                  onLongPress: () {
                    showModalBottomSheet(
                        useRootNavigator: true,
                        isScrollControlled: true,
                        elevation: 100,
                        backgroundColor: Colors.black38,
                        context: context,
                        builder: (context) {
                          return BottomSheetWidget(con: con, song: song);
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: song.coverImageUrl!,
                              width: 150,
                              height: 150,
                              progressIndicatorBuilder: (context, url, l) =>
                                  const LoadingImage(size: 80),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            song.songname!,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}

class HorizontalArtistList extends StatelessWidget {
  final List<User> users;
  final MainController con;
  const HorizontalArtistList({
    Key? key,
    required this.users,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          ...users
              .map(
                (user) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArtistProfile(
                                username: user.username!, con: con)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: user.avatar!,
                              width: 150,
                              height: 150,
                              progressIndicatorBuilder: (context, url, l) =>
                                  const LoadingImage(
                                size: 80,
                                icon: Icon(
                                  LineIcons.user,
                                  size: 80,
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user.name!,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
