import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:async';

class CommentService {
  Future<dynamic> addComment(item) async {
    String path = '/comment';
    var endpoint = Uri.http('${Config.postApiUrl}', path);
    var reqBody = {
      'uuid': item['uuid'],
      'createdBy': item['createdBy'],
      'text': item['text'],
    };

    Map<String, String> headers = {'Content-Type': 'application/json'};

    var content;
    var comment;

    try {
      content = await http.post(endpoint,
          headers: headers, body: jsonEncode(reqBody));
    } catch (e) {
      print(e);
      comment = null;
    }

    comment = jsonDecode(content.body);

    if (content.statusCode == 500) {
      comment = null;
    }

    return comment;
  }

  Future<bool> updateComment(String uuid, item) async {
    String path = '/comment/$uuid';
    var endpoint = Uri.http('${Config.postApiUrl}', path);
    var reqBody = {
      'text': item['text'],
    };

    Map<String, String> headers = {'Content-Type': 'application/json'};
    bool succeed = true;
    var content;

    try {
      content = await http.patch(endpoint,
          headers: headers, body: jsonEncode(reqBody));
    } catch (e) {
      print(e);
      succeed = false;
    }

    if (content.statusCode == 500) {
      succeed = false;
    }

    return succeed;
  }

  Future<bool> deleteComment(String uuid) async {
    String path = '/comment/$uuid';
    var endpoint = Uri.http('${Config.postApiUrl}', path);
    bool succeed = true;
    var content;

    try {
      content = await http.delete(endpoint);
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
