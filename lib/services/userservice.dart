import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:async';
import 'package:NewApp/models/user.dart';
import 'package:flutter/foundation.dart';

User parseUser(dataItem) {
  var response = User.fromJson(dataItem);
  return response;
}

class UserService {
  Future<bool> createUser(body) async {
    String path = '/user';
    var endpoint = Uri.http('${Config.userApiUrl}', path);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var reqBody = {
      'username': body['username'],
      'email': body['email'],
      'firstName': body['firstName'],
      'lastName': body['lastName'],
      'fullName': body['fullName'],
      'picLink': body['picLink']
    };
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

  Future<bool> deleteUser(username) async {
    String path = '/user/$username';
    var endpoint = Uri.http('${Config.userApiUrl}', path);
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

  Future<bool> updateUser(body, username) async {
    String path = '/user/$username';
    var endpoint = Uri.http('${Config.userApiUrl}', path);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var reqBody = {
      'username': body['username'],
      'email': body['email'],
      'firstName': body['firstName'],
      'lastName': body['lastName'],
      'fullName': body['fullName'],
      'picLink': body['picLink']
    };
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

  Future<User> getUser(username) async {
    String path = '/user/$username';
    var endpoint = Uri.http('${Config.userApiUrl}', path);
    var response;
    try {
      response = http.get(endpoint);
    } catch (e) {
      print(e);
    }
    return compute(parseUser, json.decode(response.body));
  }
}
