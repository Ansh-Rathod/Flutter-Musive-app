import 'dart:convert';

import 'package:spotify_clone/api/url.dart';
import 'package:spotify_clone/methods/get_response.dart';
import 'package:spotify_clone/models/song_model.dart';
import 'package:spotify_clone/models/user_model.dart';

class GetArtistsData {
  Future<UserModel> getUserData(String id) async {
    final value =
        await getResponse(Uri.https(baseUrl, basePath + '/user/' + id));

    if (value.statusCode == 200) {
      final body = jsonDecode(value.body);

      return UserModel.fromJson(body['results']);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<SongModel>> getSongs(String id) async {
    final value =
        await getResponse(Uri.https(baseUrl, basePath + '/songs/' + id, {
      "page": 0.toString(),
      "limit": 100.toString(),
    }));
    if (value.statusCode == 200) {
      final body = jsonDecode(value.body);
      return ((body['results'] as List)
          .map((e) => SongModel.fromJson(e))
          .toList());
    } else {
      throw Exception('Failed to load data');
    }
  }
}
