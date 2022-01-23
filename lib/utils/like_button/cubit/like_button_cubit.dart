import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'like_button_state.dart';

class LikeButtonCubit extends Cubit<LikeButtonState> {
  LikeButtonCubit() : super(LikeButtonState.initial());

  void init(String id) {
    var box = Hive.box('liked');

    var value = box.containsKey(id);

    if (value) {
      emit(state.copyWith(isLiked: true));
    } else {
      emit(state.copyWith(isLiked: false));
    }
  }

  void like({
    required String name,
    required String fullname,
    required String track,
    required String username,
    required String cover,
    required String id,
  }) {
    var box = Hive.box('liked');

    if (state.isLiked) {
      box.delete(name);
      emit(state.copyWith(isLiked: false));
    } else {
      emit(state.copyWith(isLiked: true));

      box.put(name, {
        "songname": name,
        "fullname": fullname,
        "username": username,
        "cover": cover,
        "track": track,
        "id": id
      });
    }
  }
}
