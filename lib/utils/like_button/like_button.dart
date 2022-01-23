import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/like_button_cubit.dart';

class LikeButton extends StatelessWidget {
  final String name;
  final String fullname;
  final String username;
  final String track;
  final bool isIcon;
  final String cover;
  final String id;
  const LikeButton({
    Key? key,
    required this.name,
    required this.fullname,
    required this.username,
    required this.track,
    required this.isIcon,
    required this.cover,
    required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikeButtonCubit()..init(name),
      child: BlocBuilder<LikeButtonCubit, LikeButtonState>(
        builder: (context, state) {
          if (isIcon) {
            return ListTile(
                minLeadingWidth: 30,
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                onTap: () {
                  BlocProvider.of<LikeButtonCubit>(context).like(
                    track: track,
                    fullname: fullname,
                    cover: cover,
                    id: id,
                    name: name,
                    username: username,
                  );
                },
                leading: !state.isLiked
                    ? const Icon(
                        CupertinoIcons.heart,
                        color: Colors.grey,
                      )
                    : Icon(
                        CupertinoIcons.heart_solid,
                        color: Colors.lightGreen[700],
                      ),
                title: Text(
                  !state.isLiked ? "like" : "liked",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 20, color: Colors.white),
                ));
          } else {
            return InkWell(
              onTap: () {
                BlocProvider.of<LikeButtonCubit>(context).like(
                  track: track,
                  fullname: fullname,
                  cover: cover,
                  name: name,
                  username: username,
                  id: id,
                );
              },
              child: !state.isLiked
                  ? const Icon(
                      CupertinoIcons.heart,
                      color: Colors.grey,
                      size: 30,
                    )
                  : Icon(
                      CupertinoIcons.heart_solid,
                      color: Colors.lightGreen[700],
                      size: 30,
                    ),
            );
          }
        },
      ),
    );
  }
}
