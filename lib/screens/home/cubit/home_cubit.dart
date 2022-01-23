import 'package:bloc/bloc.dart';
import 'package:spotify_clone/models/loading_enum.dart';
import 'package:spotify_clone/models/song_model.dart';
import 'package:spotify_clone/repositories/get_home_page.dart';

import '../../../models/user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final repo = GetHomePage();
  HomeCubit() : super(HomeState.initial());

  void getUsers() async {
    try {
      emit(state.copyWith(status: LoadPage.loading));

      emit(state.copyWith(
        users: await repo.getUsers(),
        songs: await repo.getSongs(),
        status: LoadPage.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: LoadPage.error));
    }
  }
}
