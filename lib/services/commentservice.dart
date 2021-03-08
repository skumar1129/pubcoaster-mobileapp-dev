import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:async';

class CommentService {
  // TODO: Add auth token in header for all calls (will do when firebase is implemented)

  Future<bool> addComment(item) async {
    String endpoint = '${Config.localUrl}/comment';
    // TODO: Add user from local storage
    var reqBody = {
      'uuid': item['uuid'],
      'createdBy': item['createdBy'],
      'text': item['text'],
    };

    // TODO: add more to headers
    Map<String, String> headers = {'Content-Type': 'application/json'};

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
    String endpoint = '${Config.localUrl}/comment/$uuid';
    var reqBody = {
      'text': item['text'],
    };

    Map<String, String> headers = {'Content-Type': 'application/json'};
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
    String endpoint = '${Config.localUrl}/comment/$uuid';
    bool succeed;

    try {
      await http.delete(endpoint);
      succeed = true;
    } catch (e) {
      print(e);
      succeed = false;
    }

    return succeed;
  }
}
