import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/main_controller.dart';
import '../methods/get_greeting.dart';

import '../models/user.dart';
import '../screens/artist_profile/artist_profile.dart';
import 'loading.dart';

class RecentUsers extends StatelessWidget {
  final List<User> users;
  final MainController con;
  const RecentUsers({
    Key? key,
    required this.users,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

    final greet = greeting();
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: users[0].avatar!,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * .15,
          width: MediaQuery.of(context).size.width * .67,
          memCacheHeight: ((MediaQuery.of(context).size.height * .15) *
                  MediaQuery.of(context).devicePixelRatio)
              .round(),
          memCacheWidth: ((MediaQuery.of(context).size.width * .67) *
                  MediaQuery.of(context).devicePixelRatio)
              .round(),
          alignment: Alignment.topLeft,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  greet,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    ...users
                        .map((user) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => ArtistProfile(
                                              username: user.username!,
                                              con: con,
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                width:
                                    ((MediaQuery.of(context).size.width * .5) -
                                        21.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        bottomLeft: Radius.circular(3),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: user.avatar!,
                                        width: 55,
                                        height: 55,
                                        memCacheHeight:
                                            (55 * devicePexelRatio).round(),
                                        memCacheWidth:
                                            (55 * devicePexelRatio).round(),
                                        maxHeightDiskCache:
                                            (55 * devicePexelRatio).round(),
                                        maxWidthDiskCache:
                                            (55 * devicePexelRatio).round(),
                                        progressIndicatorBuilder:
                                            (context, url, l) =>
                                                const LoadingImage(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          user.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
