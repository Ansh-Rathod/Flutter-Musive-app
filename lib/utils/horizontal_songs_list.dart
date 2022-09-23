import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../controllers/main_controller.dart';
import '../models/song_model.dart';
import '../models/user.dart';
import '../screens/artist_profile/artist_profile.dart';
import 'loading.dart';

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
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

    return SizedBox(
      height: 210,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: songs.length,
          itemBuilder: (context, i) {
            final song = songs[i];
            return InkWell(
              onTap: () {
                con.playSong(con.convertToAudio(songs), songs.indexOf(song));
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
                          maxHeightDiskCache: (200 * devicePexelRatio).round(),
                          maxWidthDiskCache: (200 * devicePexelRatio).round(),
                          memCacheHeight: (200 * devicePexelRatio).round(),
                          memCacheWidth: (200 * devicePexelRatio).round(),
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
            );
          }),
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
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

    return SizedBox(
      height: 210,
      child: ListView.builder(
          itemCount: users.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            final user = users[i];
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ArtistProfile(username: user.username!, con: con)));
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
                          maxHeightDiskCache: (200 * devicePexelRatio).round(),
                          maxWidthDiskCache: (200 * devicePexelRatio).round(),
                          memCacheHeight: (200 * devicePexelRatio).round(),
                          memCacheWidth: (200 * devicePexelRatio).round(),
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
            );
          }),
    );
  }
}
