part of 'home_cubit.dart';

class HomeState {
  final LoadPage status;
  final List<User> users;
  final List<SongModel> songs;
  HomeState({
    required this.status,
    required this.users,
    required this.songs,
  });
  factory HomeState.initial() {
    return HomeState(
      songs: [],
      status: LoadPage.initial,
      users: [],
    );
  }

  HomeState copyWith({
    LoadPage? status,
    List<User>? users,
    List<SongModel>? songs,
  }) {
    return HomeState(
      status: status ?? this.status,
      users: users ?? this.users,
      songs: songs ?? this.songs,
    );
  }
}
