import 'package:bloc/bloc.dart';
import 'package:spotify_clone/controllers/main_controller.dart';
import 'package:spotify_clone/models/loading_enum.dart';
import 'package:spotify_clone/repositories/get_artists_data.dart';

import '../../../models/song_model.dart';
import '../../../models/user_model.dart';

part 'artist_profile_state.dart';

class ArtistProfileCubit extends Cubit<ArtistProfileState> {
  final repo = GetArtistsData();
  ArtistProfileCubit() : super(ArtistProfileState.initial());
  void getUser(String id) async {
    try {
      emit(state.copyWith(status: LoadPage.loading));
      emit(
        state.copyWith(
          songs: await repo.getSongs(id),
          user: await repo.getUserData(id),
          status: LoadPage.loaded,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: LoadPage.error));
    }
  }

  void playSongs(MainController controller, int initial) {
    controller.playSong(controller.convertToAudio(state.songs), initial);
  }
}
