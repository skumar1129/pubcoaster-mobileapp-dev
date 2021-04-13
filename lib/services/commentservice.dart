import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:async';

class CommentService {
  // TODO: Add auth token in header for all calls (will do when firebase is implemented)

  Future<bool> addComment(item) async {
    String path = '/comment';
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var endpoint = Uri.https('${Config.postApiUrl}', path);
    // TODO: Add user from local storage
    var reqBody = {
      'uuid': item['uuid'],
      'createdBy': item['createdBy'],
      'text': item['text'],
    };

    // TODO: add more to headers

    bool succeed;
    try {
      await http.post(endpoint, headers: headers, body: jsonEncode(reqBody));
      succeed = true;
    } catch (e) {
      print(e);
      succeed = false;
    }

    return succeed;
  }

  Future<bool> updateComment(String uuid, item) async {
    String path = '/comment/$uuid';
    var endpoint = Uri.https('${Config.postApiUrl}', path);
    var reqBody = {
      'text': item['text'],
    };
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    bool succeed;

    try {
      await http.patch(endpoint, headers: headers, body: jsonEncode(reqBody));
      succeed = true;
    } catch (e) {
      print(e);
      succeed = false;
    }

    return succeed;
  }

  Future<bool> deleteComment(String uuid) async {
    String path = '/comment/$uuid';
    var endpoint = Uri.https('${Config.postApiUrl}', path);
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
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
