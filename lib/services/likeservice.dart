import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:async';

class LikeService {
  // TODO: Add auth token in header for all calls (will do when firebase is implemented)

  Future<bool> addLike(item) async {
    String endpoint = "${Config.localUrl}/like/${item['uuid']}";
    // TODO: Add user from local storage

    Map<String, String> headers = {'username': item['username']};
    bool succeed;
    try {
      await http.post(endpoint as Uri, headers: headers);
      succeed = true;
    } catch (e) {
      print(e);
      succeed = false;
    }

    return succeed;
  }

  Future<bool> deleteLike(item) async {
    String endpoint = "${Config.localUrl}/like/${item['uuid']}";
    // TODO: Add user from local storage

    bool succeed;

    Map<String, String> headers = {'username': item['username']};
    try {
      await http.delete(endpoint as Uri, headers: headers);
      succeed = true;
    } catch (e) {
      print(e);
      succeed = false;
    }

    return succeed;
  }
}
