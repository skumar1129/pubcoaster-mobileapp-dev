import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:async';

class LikeService {
  // TODO: Add auth token in header for all calls (will do when firebase is implemented)

  Future<bool> addLike(item) async {
    String path = '/like/${item['uuid']}';
    var endpoint = Uri.https('${Config.postApiUrl}', path);
    // TODO: Add user from local storage
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'username': item['username']
    };
    bool succeed;
    try {
      await http.post(endpoint, headers: headers);
      succeed = true;
    } catch (e) {
      print(e);
      succeed = false;
    }

    return succeed;
  }

  Future<bool> deleteLike(item) async {
    String path = '/like/${item['uuid']}';
    var endpoint = Uri.https('${Config.postApiUrl}', path);
    // TODO: Add user from local storage
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'username': item['username']
    };
    bool succeed;

    try {
      await http.delete(endpoint, headers: headers);
      succeed = true;
    } catch (e) {
      print(e);
      succeed = false;
    }

    return succeed;
  }
}
