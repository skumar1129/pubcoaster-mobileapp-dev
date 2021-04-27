import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:async';
import 'package:NewApp/models/user.dart';
import 'package:flutter/foundation.dart';

ProfUser parseUser(dataItem) {
  var response = ProfUser.fromJson(dataItem);
  return response;
}

class UserService {
  Future<bool> createUser(body) async {
    String path = '/user';
    var endpoint = Uri.https('${Config.userApiUrl}', path);
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var reqBody = {
      'username': body['username'],
      'email': body['email'],
      'firstName': body['firstName'],
      'lastName': body['lastName'],
      'fullName': body['fullName'],
      'picLink': body['picLink']
    };
    bool succeed = true;
    var content;

    try {
      content = await http.post(endpoint, headers: headers, body: jsonEncode(reqBody));
    } catch (e) {
      print(e);
      succeed = false;
    }

    if (content.statusCode == 500) {
      succeed = false;
    }

    return succeed;
  }

  Future<bool> deleteUser(username) async {
    String path = '/user/$username';
    var endpoint = Uri.https('${Config.userApiUrl}', path);
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    bool succeed = true;
    var content;

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

  Future<bool> updateUser(body, username) async {
    String path = '/user/$username';
    var endpoint = Uri.https('${Config.userApiUrl}', path);
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var reqBody = {
      'username': body['username'],
      'email': body['email'],
      'firstName': body['firstName'],
      'lastName': body['lastName'],
      'fullName': body['fullName'],
      'picLink': body['picLink']
    };
    bool succeed = true;
    var content;
    try {
      content = await http.post(endpoint,
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

  Future<ProfUser> getUser(username) async {
    String path = '/user/$username';
    var endpoint = Uri.https('${Config.userApiUrl}', path);
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response;
    try {
      response = http.get(endpoint, headers: headers);
    } catch (e) {
      print(e);
    }
    return compute(parseUser, json.decode(response.body));
  }
}
