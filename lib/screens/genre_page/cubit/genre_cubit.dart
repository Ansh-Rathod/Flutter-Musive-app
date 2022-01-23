import 'package:bloc/bloc.dart';
import 'package:spotify_clone/controllers/main_controller.dart';
import 'package:spotify_clone/models/loading_enum.dart';
import 'package:spotify_clone/models/song_model.dart';
import 'package:spotify_clone/models/user.dart';
import 'package:spotify_clone/repositories/get_genre_data.dart';

part 'genre_state.dart';

class GenreCubit extends Cubit<GenreState> {
  final repo = GenreRepository();

  GenreCubit() : super(GenreState.initial());
  void init(String tag) async {
    try {
      emit(state.copyWith(status: LoadPage.loading));
      var users = await repo.getUsers(tag);
      var songs = await repo.getSongs(tag);
      emit(state.copyWith(
        status: LoadPage.loaded,
        users: users,
        songs: songs,
      ));
    } catch (e) {
      emit(state.copyWith(status: LoadPage.error));
    }
  }

  void playSongs(MainController controller, int initial) {
    controller.playSong(controller.convertToAudio(state.songs), initial);
  }
}
