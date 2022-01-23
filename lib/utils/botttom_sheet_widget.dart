import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/controllers/main_controller.dart';
import 'package:spotify_clone/methods/snackbar.dart';
import 'package:spotify_clone/models/song_model.dart';
import 'package:spotify_clone/screens/add_to_playlist/add_to_playlist.dart';
import 'package:url_launcher/url_launcher.dart';

import 'like_button/like_button.dart';
import 'loading.dart';

class BottomSheetWidget extends StatelessWidget {
  final MainController con;
  final bool? isNext;
  final SongModel song;
  const BottomSheetWidget({
    Key? key,
    required this.con,
    this.isNext,
    required this.song,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .3,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: song.coverImageUrl!,
                    progressIndicatorBuilder: (context, url, l) =>
                        const LoadingImage(),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.music_note,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Listen on spotify",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            song.songname!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 5),
          Text(
            song.name!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 20),
          LikeButton(
            id: song.songid!,
            isIcon: true,
            cover: song.coverImageUrl!,
            fullname: song.name!,
            name: song.songname!,
            track: song.trackid!,
            username: song.userid!,
          ),
          if (isNext == null)
            ListTile(
              onTap: () {
                var title = con.player.getCurrentAudioTitle;
                Audio currentSong =
                    con.findByname(con.player.playlist!.audios, title);
                int currentIndex =
                    con.player.playlist!.audios.indexOf(currentSong);
                con.player.playlist!
                    .insert(currentIndex + 1, con.convertToAudio([song])[0]);
                context.showSnackBar(message: "Added to Queue");
                Navigator.pop(context);
              },
              minLeadingWidth: 30,
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(
                CupertinoIcons.play_arrow,
                color: Colors.grey,
              ),
              title: Text(
                "Play Next",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 20, color: Colors.white),
              ),
            ),
          ListTile(
            onTap: () {
              con.player.playlist!.add(con.convertToAudio([song])[0]);
              context.showSnackBar(message: "Added to Queue");
              Navigator.pop(context);
            },
            minLeadingWidth: 30,
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            leading: const Icon(
              Icons.playlist_add,
              color: Colors.grey,
            ),
            title: Text(
              "Add To queue",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return AddToPlaylist(
                  id: song.songid!,
                  cover: song.coverImageUrl!,
                  fullname: song.name!,
                  name: song.songname!,
                  track: song.trackid!,
                  username: song.userid!,
                );
              }));
            },
            minLeadingWidth: 30,
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            leading: const Icon(
              CupertinoIcons.music_albums,
              color: Colors.grey,
            ),
            title: Text(
              "Add to Playlist",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            onTap: () {
              launch(song.trackid!);
            },
            minLeadingWidth: 30,
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            leading: const Icon(
              Icons.download,
              color: Colors.grey,
            ),
            title: Text(
              "Download",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 20, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
