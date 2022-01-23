import 'package:http/http.dart' as http;

getResponse(Uri url) async {
  http.Response response = await http.get(url);
  return response;
}
