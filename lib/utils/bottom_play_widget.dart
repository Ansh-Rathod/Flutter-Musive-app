import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/main_controller.dart';

import 'loading.dart';

class PlayWidget extends StatelessWidget {
  final MainController con;
  final void Function()? onTap;
  const PlayWidget({
    Key? key,
    required this.con,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

    return con.player.builderCurrent(builder: (context, playing) {
      final myAudio = con.find(con.audios, playing.audio.assetAudioPath);
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: kElevationToShadow[9],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: myAudio.metas.image!.path,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  memCacheHeight: (70 * devicePexelRatio).round(),
                  memCacheWidth: (70 * devicePexelRatio).round(),
                  maxHeightDiskCache: (70 * devicePexelRatio).round(),
                  maxWidthDiskCache: (70 * devicePexelRatio).round(),
                  progressIndicatorBuilder: (context, url, l) =>
                      const LoadingImage(),
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: CachedNetworkImage(
                                  imageUrl: myAudio.metas.image!.path,
                                  width: 40,
                                  height: 40,
                                  memCacheHeight:
                                      (70 * devicePexelRatio).round(),
                                  memCacheWidth:
                                      (70 * devicePexelRatio).round(),
                                  maxHeightDiskCache:
                                      (70 * devicePexelRatio).round(),
                                  maxWidthDiskCache:
                                      (70 * devicePexelRatio).round(),
                                  progressIndicatorBuilder: (context, url, l) =>
                                      const LoadingImage(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myAudio.metas.title!,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        myAudio.metas.artist!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: Colors.grey,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PlayerBuilder.isPlaying(
                            player: con.player,
                            builder: (context, isPlaying) {
                              return IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  con.player.playOrPause();
                                },
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 36,
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
