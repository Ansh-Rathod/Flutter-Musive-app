import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spotify_clone/models/song_model.dart';

class MainController extends ChangeNotifier {
  var audios = <Audio>[
    Audio.network(
      'https://cdn.pixabay.com/download/audio/2022/01/20/audio_f1b4f4c8b1.mp3?filename=welcome-to-the-games-15238.mp3',
      metas: Metas(
        id: 'Online',
        title: 'Welcome Here',
        artist: 'Ansh Rathod',
        album: 'OnlineAlbum',
        image: const MetasImage.network(
            'https://images.unsplash.com/photo-1611339555312-e607c8352fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
      ),
    ),
  ];
  bool isNext = true;
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('Playing audio');

  final List<StreamSubscription> _subscriptions = [];
  List<dynamic> getRecentlyPlayed() {
    List<dynamic> data = [];
    var box = Hive.box('RecentlyPlayed');
    for (var i = 0; i < box.length; i++) {
      data.add(box.getAt(i));
    }
    return data;
  }

  List<Audio> converLocalSongToAudio(songs) {
    return (songs as List).map((audio) {
      return Audio.network(audio['track'],
          metas: Metas(
            id: audio['id'],
            title: audio['songname'],
            artist: audio['fullname'],
            album: audio['username'],
            image: MetasImage.network(audio['cover']),
          ));
    }).toList();
  }

  void init() async {
    _subscriptions.add(player.playlistAudioFinished.listen((data) async {
      final myAudio = data.playlist.audios[data.playlist.currentIndex];
      var box = Hive.box('RecentlyPlayed');
      await box.put(myAudio.metas.title, {
        "songname": myAudio.metas.title,
        "fullname": myAudio.metas.artist,
        "username": myAudio.metas.album,
        "cover": myAudio.metas.image!.path,
        "track": myAudio.path,
        "id": myAudio.metas.id,
        "created": DateTime.now().toString(),
      });
    }));

    _subscriptions.add(player.audioSessionId.listen((sessionId) {}));
    _subscriptions
        .add(AssetsAudioPlayer.addNotificationOpenAction((notification) {
      return false;
    }));
    final recentSongs = getRecentlyPlayed();
    recentSongs.sort((a, b) => a["created"].compareTo(b["created"]));
    if (recentSongs.isNotEmpty) {
      audios.removeAt(0);
    }
    converLocalSongToAudio(recentSongs).forEach((audio) {
      audios.add(audio);
    });
    await openPlayer(newlist: audios);
  }

  void addToFavorite(
      {required String name,
      required String fullname,
      required String username,
      required String cover,
      required String track}) {
    var box = Hive.box('liked');

    box.put(name, {
      "songname": name,
      "fullname": fullname,
      "username": username,
      "cover": cover,
      "track": track
    });
  }

  Future<void> openPlayer(
      {required List<Audio> newlist, int initial = 0}) async {
    await player.open(Playlist(audios: newlist, startIndex: initial),
        showNotification: true,
        autoStart: false,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
        notificationSettings: const NotificationSettings(stopEnabled: false));

    notifyListeners();
  }

  void playSong(List<Audio> newPlaylist, int initial) async {
    if (isNext) {
      isNext = false;
      await player.pause();
      await player.stop();
      audios = newPlaylist;
      await openPlayer(newlist: newPlaylist, initial: initial);
      await player.play();
      isNext = true;
    }
  }

  void changeIndex(int newIndex, int oldIndex) {
    player.playlist!.audios
        .insert(newIndex, player.playlist!.audios.removeAt(oldIndex));

    notifyListeners();
  }

  void close() {
    player.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  Audio findByname(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.metas.title == fromPath);
  }

  List<Audio> convertToAudio(List<SongModel> songs) {
    return [
      ...songs.map((audio) {
        return Audio.network(audio.trackid!,
            metas: Metas(
              id: audio.songid,
              title: audio.songname,
              artist: audio.name,
              album: audio.userid,
              image: MetasImage.network(audio.coverImageUrl!),
            ));
      }).toList()
    ];
  }
}
