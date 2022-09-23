import 'dart:convert';

import 'package:http/http.dart';
import '../api/url.dart';
import '../methods/get_response.dart';
import '../models/song_model.dart';

class GetOneSong {
  Future<SongModel> getSongs(String name) async {
    Response res =
        await getResponse(Uri.https(baseUrl, basePath + '/songs/one/' + name));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      return SongModel.fromJson(body['results'][0]);
    } else {
      throw Exception("failed fetch users ");
    }
  }
}
