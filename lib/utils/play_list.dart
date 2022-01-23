import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/controllers/main_controller.dart';

import 'loading.dart';

class PlayListWidget extends StatefulWidget {
  final MainController con;
  final List<Audio> audios;
  const PlayListWidget({
    Key? key,
    required this.con,
    required this.audios,
  }) : super(key: key);

  @override
  _PlayListWidgetState createState() => _PlayListWidgetState();
}

class _PlayListWidgetState extends State<PlayListWidget> {
  Audio findSong(title) {
    final currentlyPlayingAudio = widget.con.findByname(widget.audios, title);

    return currentlyPlayingAudio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Playlist",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Builder(builder: (context) {
          final currentlyPlayingAudio = widget.con.findByname(
              widget.audios, widget.con.player.getCurrentAudioTitle);
          int indexOfCurrentAudio =
              widget.audios.indexOf(currentlyPlayingAudio);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text(
                    "Playing Now",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ),
                InkWell(
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: CachedNetworkImage(
                              imageUrl: widget.audios[indexOfCurrentAudio].metas
                                  .image!.path,
                              width: 50,
                              height: 50,
                              progressIndicatorBuilder: (context, url, l) =>
                                  const LoadingImage(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.audios[indexOfCurrentAudio].metas
                                            .title ??
                                        '',
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                          color: Colors.lightGreen[700],
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.audios[indexOfCurrentAudio].metas
                                        .artist!,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text(
                    "Next Songs",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ),
                ReorderableListView.builder(
                  itemCount:
                      widget.audios.sublist(indexOfCurrentAudio + 1).length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  onReorder: (int oldIndex, int newIndex) async {
                    final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                    setState(() {
                      widget.audios.insert(
                          indexOfCurrentAudio + 1 + index,
                          widget.audios
                              .removeAt(indexOfCurrentAudio + 1 + oldIndex));
                    });
                  },
                  itemBuilder: (context, i) {
                    final newAudio =
                        widget.audios.sublist(indexOfCurrentAudio + 1)[i];
                    return InkWell(
                      onTap: () async {
                        await widget.con.player.playlistPlayAtIndex(widget
                            .audios
                            .indexOf(findSong(newAudio.metas.title)));
                        setState(() {});
                      },
                      key: ValueKey(newAudio),
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: CachedNetworkImage(
                                  imageUrl: newAudio.metas.image!.path,
                                  width: 50,
                                  height: 50,
                                  progressIndicatorBuilder: (context, url, l) =>
                                      const LoadingImage(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newAudio.metas.title ?? '',
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        newAudio.metas.artist!,
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
                              const Icon(
                                CupertinoIcons.line_horizontal_3,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
