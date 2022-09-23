import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../controllers/main_controller.dart';
import '../methods/snackbar.dart';
import '../models/song_model.dart';
import '../screens/artist_profile/artist_profile.dart';
import 'loading.dart';

import 'botttom_sheet_widget.dart';

class RecentSearch extends StatelessWidget {
  final MainController con;

  const RecentSearch({
    Key? key,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> data = [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        if (Hive.box('Recentsearch').length != 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text(
              'Recent Searches'.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ValueListenableBuilder<Box>(
            valueListenable: Hive.box('Recentsearch').listenable(),
            builder: (context, box, child) {
              if (box.isEmpty) {
                return const SizedBox(
                  height: 300,
                  child: Center(
                    child: Text(
                      "Keep Searching..",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  final info = Hive.box('Recentsearch').getAt(i);
                  if (info['type'] == 'SONG') {
                    data.add(info);
                  }
                  return Dismissible(
                    key: Key(info['songname'].toString()),
                    onDismissed: (direction) {
                      box.deleteAt(i);
                      context.showSnackBar(
                          message: "Removed from Recent Searchlist.");
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Icon(
                          CupertinoIcons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (info['type'] == 'SONG') {
                          con.playSong(con.converLocalSongToAudio(data), i);
                        } else {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => ArtistProfile(
                                        username: info['fullname'],
                                        con: con,
                                      )));
                        }
                      },
                      leading: ClipRRect(
                        borderRadius: info['type'] == 'SONG'
                            ? BorderRadius.circular(5)
                            : BorderRadius.circular(50),
                        child: CachedNetworkImage(
                            imageUrl: info['cover'],
                            width: 50,
                            height: 50,
                            memCacheHeight:
                                (50 * MediaQuery.of(context).devicePixelRatio)
                                    .round(),
                            memCacheWidth:
                                (50 * MediaQuery.of(context).devicePixelRatio)
                                    .round(),
                            placeholder: (context, u) => const LoadingImage(),
                            fit: BoxFit.cover),
                      ),
                      title: Text(
                        info['songname'],
                        maxLines: 1,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        info['fullname'],
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: info['type'] == 'SONG'
                          ? IconButton(
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
                                          song: SongModel(
                                            songid: info['id'],
                                            songname: info['songname'],
                                            userid: info['username'],
                                            trackid: info['track'],
                                            duration: '',
                                            coverImageUrl: info['cover'],
                                            name: info['fullname'],
                                          ));
                                    });
                              },
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.play_circle_outline,
                              color: Colors.transparent,
                            ),
                    ),
                  );
                },
                itemCount: box.length,
              );
            }),
      ],
    );
  }
}
