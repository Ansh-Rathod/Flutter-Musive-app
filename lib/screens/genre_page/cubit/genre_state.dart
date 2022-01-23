part of 'genre_cubit.dart';

class GenreState {
  final LoadPage status;
  final List<SongModel> songs;
  final List<User> users;
  GenreState({
    required this.status,
    required this.songs,
    required this.users,
  });

  factory GenreState.initial() =>
      GenreState(songs: [], users: [], status: LoadPage.initial);

  GenreState copyWith({
    LoadPage? status,
    List<SongModel>? songs,
    List<User>? users,
  }) {
    return GenreState(
      status: status ?? this.status,
      songs: songs ?? this.songs,
      users: users ?? this.users,
    );
  }
}
