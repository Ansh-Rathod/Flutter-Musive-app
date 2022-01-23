// ignore: file_names
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:spotify_clone/controllers/main_controller.dart';

class PlayingControls extends StatefulWidget {
  final bool isPlaying;
  final LoopMode? loopMode;
  final bool isPlaylist;
  final MainController con;
  final Function()? onPrevious;
  final Function() onPlay;
  final Function()? onNext;
  final Function()? toggleLoop;
  final Function()? onStop;

  const PlayingControls({
    Key? key,
    required this.isPlaying,
    this.loopMode,
    this.isPlaylist = false,
    required this.con,
    this.onPrevious,
    required this.onPlay,
    this.onNext,
    this.toggleLoop,
    this.onStop,
  }) : super(key: key);

  @override
  State<PlayingControls> createState() => _PlayingControlsState();
}

class _PlayingControlsState extends State<PlayingControls> {
  bool isSuffled = false;
  @override
  void initState() {
    setState(() {
      isSuffled = widget.con.player.shuffle;
    });
    super.initState();
  }

  Icon loopIcon(BuildContext context) {
    if (widget.loopMode == LoopMode.none) {
      return const Icon(
        CupertinoIcons.arrow_2_circlepath,
        color: Colors.grey,
        size: 24,
      );
    } else if (widget.loopMode == LoopMode.playlist) {
      return const Icon(
        CupertinoIcons.arrow_2_circlepath,
        size: 24,
        color: Colors.white,
      );
    } else {
      return const Icon(
        CupertinoIcons.arrow_2_circlepath,
        size: 24,
        color: Colors.green,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            padding: const EdgeInsets.all(0),
            splashRadius: 24,
            onPressed: () {
              setState(() {
                isSuffled = !isSuffled;
              });
              widget.con.player.toggleShuffle();
            },
            icon: isSuffled
                ? const Icon(LineIcons.random, color: Colors.green)
                : const Icon(LineIcons.random, color: Colors.white),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: widget.isPlaylist ? widget.onPrevious : null,
                icon: const Icon(
                  Icons.skip_previous,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 80,
                width: 120,
                child: IconButton(
                  onPressed: widget.onPlay,
                  icon: Icon(
                    widget.isPlaying
                        ? CupertinoIcons.pause_circle_fill
                        : CupertinoIcons.play_circle_fill,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: widget.isPlaylist ? widget.onNext : null,
                icon: const Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
          IconButton(
            padding: const EdgeInsets.all(0),
            splashRadius: 24,
            onPressed: () {
              if (widget.toggleLoop != null) widget.toggleLoop!();
            },
            icon: loopIcon(context),
          ),
        ],
      ),
    );
  }
}
