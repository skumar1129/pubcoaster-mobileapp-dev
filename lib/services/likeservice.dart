import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:async';

class LikeService {
  Future<bool> addLike(item) async {
    String path = '/like/${item['uuid']}';
    var endpoint = Uri.http('${Config.postApiUrl}', path);

    Map<String, String> headers = {'username': item['username']};
    bool succeed = true;
    var content;

    try {
      content = await http.post(endpoint, headers: headers);
    } catch (e) {
      print(e);
      succeed = false;
    }

    if (content.statusCode == 500) {
      succeed = false;
    }

    return succeed;
  }

  Future<bool> deleteLike(item) async {
    String path = '/like/${item['uuid']}';
    var endpoint = Uri.http('${Config.postApiUrl}', path);

    bool succeed = true;
    var content;

    Map<String, String> headers = {'username': item['username']};
    try {
      content = await http.delete(endpoint, headers: headers);
    } catch (e) {
      print(e);
      succeed = false;
    }

    if (content.statusCode == 500) {
      succeed = false;
    }

    return succeed;
  }
}
