import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:spotify_clone/controllers/main_controller.dart';
import 'package:spotify_clone/models/loading_enum.dart';
import 'package:spotify_clone/screens/artist_profile/artist_profile.dart';
import 'package:spotify_clone/utils/botttom_sheet_widget.dart';
import 'package:spotify_clone/utils/loading.dart';
import 'package:spotify_clone/utils/recent_search.dart';

import 'cubit/search_results_cubit.dart';

class SearchResultsPage extends StatelessWidget {
  final MainController con;
  const SearchResultsPage({
    Key? key,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchResultsCubit(),
        child: BlocBuilder<SearchResultsCubit, SearchResultsState>(
            builder: (context, state) {
          return Scaffold(
              appBar: CustomAppBar(
                onPressed: () {
                  BlocProvider.of<SearchResultsCubit>(context).isSongToggle();
                },
                onChanged: (String? s) {
                  if (s == '' || s == null) {
                    BlocProvider.of<SearchResultsCubit>(context).isNullToggle();
                  } else {
                    if (state.isNull) {
                      BlocProvider.of<SearchResultsCubit>(context)
                          .isNullToggle();
                    }
                    BlocProvider.of<SearchResultsCubit>(context).searchSongs(s);
                  }
                },
                isSong: state.isSong,
              ),
              body: Builder(
                builder: (context) {
                  if (state.status == LoadPage.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.status == LoadPage.loaded) {
                    if (state.isNull) {
                      return RecentSearch(con: con);
                    } else if (state.isSong) {
                      return ListView.builder(
                          itemCount: state.songs.length,
                          itemBuilder: (context, i) {
                            bool isPlaying = con.player.getCurrentAudioTitle ==
                                state.songs[i].songname;
                            return InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                BlocProvider.of<SearchResultsCubit>(context)
                                    .playSongs(con, i);
                                var box = Hive.box('Recentsearch');
                                box.put(state.songs[i].songname, {
                                  "songname": state.songs[i].songname,
                                  "fullname": state.songs[i].name,
                                  "username": state.songs[i].userid,
                                  "cover": state.songs[i].coverImageUrl,
                                  "track": state.songs[i].trackid,
                                  "id": state.songs[i].songid,
                                  "type": "SONG"
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, bottom: 12.0, top: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  state.songs[i].coverImageUrl!,
                                              width: 50,
                                              height: 50,
                                              progressIndicatorBuilder:
                                                  (context, url, l) =>
                                                      const LoadingImage(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.songs[i].songname!,
                                                    maxLines: 1,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: isPlaying
                                                                ? Colors.lightGreenAccent[
                                                                    700]
                                                                : Colors.white,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    state.songs[i].duration!,
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
                                    IconButton(
                                      splashRadius: 20,
                                      padding: const EdgeInsets.all(0),
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
                                                  song: state.songs[i]);
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                var box = Hive.box('Recentsearch');
                                box.put(state.users[i].name, {
                                  "songname": state.users[i].name,
                                  "fullname": state.users[i].username,
                                  "username": '',
                                  "cover": state.users[i].avatar,
                                  "track": '',
                                  "id": '',
                                  "type": "ARTIST"
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArtistProfile(
                                            username: state.users[i].username!,
                                            con: con)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, bottom: 12.0, top: 12.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: CachedNetworkImage(
                                        imageUrl: state.users[i].avatar!,
                                        width: 50,
                                        height: 50,
                                        progressIndicatorBuilder:
                                            (context, url, l) =>
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
                                              state.users[i].name!,
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              state.users[i].username!,
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
                            );
                          });
                    }
                  }
                  if (state.status == LoadPage.error) {
                    return const Center(
                      child: Text(
                        "Error",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return Container();
                },
              ));
        }));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String? s) onChanged;
  final bool isSong;
  final void Function() onPressed;
  const CustomAppBar({
    Key? key,
    required this.onChanged,
    required this.isSong,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey.shade800,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Container(
                color: Colors.grey.shade800,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: Colors.grey.shade800,
                    border: InputBorder.none,
                  ),
                  onChanged: onChanged,
                ),
              ),
              Container(
                color: Colors.grey.shade800,
                child: IconButton(
                  splashRadius: 20,
                  icon: isSong
                      ? const Icon(
                          LineIcons.music,
                          color: Colors.white,
                        )
                      : const Icon(
                          LineIcons.user,
                          color: Colors.white,
                        ),
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
