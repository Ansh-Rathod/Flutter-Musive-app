import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:spotify_clone/controllers/main_controller.dart';
import 'package:spotify_clone/models/song_model.dart';
import 'package:spotify_clone/utils/botttom_sheet_widget.dart';
import 'package:spotify_clone/utils/like_button/like_button.dart';
import 'package:spotify_clone/utils/loading.dart';
import 'package:spotify_clone/utils/play_list.dart';
import 'package:spotify_clone/utils/player/playing_controls.dart';
import 'package:spotify_clone/utils/player/position_seek_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CurrentPlayingSong extends StatelessWidget {
  final MainController con;
  const CurrentPlayingSong({
    Key? key,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: con.player.builderCurrent(builder: (context, playing) {
      final myAudio = con.find(con.audios, playing.audio.assetAudioPath);
      return Stack(
        children: [
          CachedNetworkImage(
            imageUrl: myAudio.metas.image!.path,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .7,
            progressIndicatorBuilder: (context, url, l) => const LoadingImage(),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child: Container(
              color: Colors.black38,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Column(
                                  children: [
                                    const Text(
                                      "NOW PLAYING",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      myAudio.metas.artist!,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    useRootNavigator: true,
                                    isScrollControlled: true,
                                    elevation: 100,
                                    backgroundColor: Colors.black38,
                                    context: context,
                                    builder: (context) {
                                      return BottomSheetWidget(
                                          con: con,
                                          isNext: true,
                                          song: SongModel(
                                            songid: myAudio.metas.id,
                                            songname: myAudio.metas.title,
                                            userid: myAudio.metas.album,
                                            trackid: myAudio.path,
                                            duration: '',
                                            coverImageUrl:
                                                myAudio.metas.image!.path,
                                            name: myAudio.metas.artist,
                                          ));
                                    });
                              },
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: CachedNetworkImage(
                            imageUrl: myAudio.metas.image!.path,
                            progressIndicatorBuilder: (context, url, l) =>
                                const LoadingImage(
                              icon: Icon(
                                LineIcons.compactDisc,
                                size: 120,
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Text(
                                      myAudio.metas.title!,
                                      maxLines: 1,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Text(
                                      myAudio.metas.artist!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            LikeButton(
                              name: myAudio.metas.title!,
                              fullname: myAudio.metas.artist!,
                              username: myAudio.metas.album!,
                              id: myAudio.metas.id!,
                              track: myAudio.path,
                              isIcon: false,
                              cover: myAudio.metas.image!.path,
                            ),
                            const SizedBox(width: 24)
                          ],
                        ),
                        con.player.builderCurrent(
                          builder: (context, Playing? playing) {
                            return Column(children: <Widget>[
                              con.player.builderRealtimePlayingInfos(builder:
                                  (context, RealtimePlayingInfos? infos) {
                                if (infos == null) {
                                  return const SizedBox();
                                }
                                return PositionSeekWidget(
                                  currentPosition: infos.currentPosition,
                                  duration: infos.duration,
                                  seekTo: (to) {
                                    con.player.seek(to);
                                  },
                                );
                              }),
                              con.player.builderLoopMode(
                                builder: (context, loopMode) {
                                  return PlayerBuilder.isPlaying(
                                      player: con.player,
                                      builder: (context, isPlaying) {
                                        return PlayingControls(
                                          loopMode: loopMode,
                                          isPlaying: isPlaying,
                                          con: con,
                                          isPlaylist: true,
                                          onStop: () {
                                            con.player.stop();
                                          },
                                          toggleLoop: () {
                                            con.player.toggleLoop();
                                          },
                                          onPlay: () {
                                            con.player.playOrPause();
                                          },
                                          onNext: () {
                                            con.player.next(keepLoopMode: true);
                                          },
                                          onPrevious: () {
                                            con.player.previous();
                                          },
                                        );
                                      });
                                },
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 26.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        launch(myAudio.path);
                                      },
                                      child: const Icon(
                                        Icons.download_sharp,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PlayListWidget(
                                              audios:
                                                  con.player.playlist!.audios,
                                              con: con,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        CupertinoIcons.music_note_list,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }));
  }
}
