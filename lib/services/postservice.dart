import 'dart:convert';
//import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:NewApp/models/feedpost.dart';
import 'package:NewApp/models/singlepost.dart';
import 'package:NewApp/models/mypost.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

List<FeedPost> parseFeedPosts(dataItems) {
  var response =
      dataItems.map<FeedPost>((json) => FeedPost.fromJson(json)).toList();
  return response;
}

SinglePost parseSinglePost(dataItem) {
  var response = SinglePost.fromJson(dataItem);
  return response;
}

List<MyPost> parseMyPosts(dataItems) {
  var response =
      dataItems.map<MyPost>((json) => MyPost.fromJson(json)).toList();
  return response;
}

// TODO: Change Uri.http to Uri.https when APIs are deployed
class PostService {
  // TODO: Add auth token in header for all calls (will do when firebase is implemented)

  Future<bool> addPost(item) async {
    var endpoint = Uri.http('${Config.postApiUrl}', '/post');
    // TODO: Add user from local storage
    var reqBody = {
      'username': item['username'],
      'anonymous': item['anonymous'],
      'location': item['location'],
      'bar': item['bar'],
      'rating': item['rating'],
      'neighborhood': item['nbhood'],
      'description': item['description'],
      'picLink': item['picLink']
    };

    // TODO: add more to headers
    Map<String, String> headers = {'Content-Type': 'application/json'};

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

  Future<bool> updatePost(String uuid, item) async {
    var endpoint = Uri.http('${Config.postApiUrl}', '/post/$uuid');
    var reqBody = {
      'picLink': '',
      'neighborhood': item['nbhood'],
      'rating': item['rating'],
      'bar': item['bar'],
      'description': item['description']
    };

    Map<String, String> headers = {'Content-Type': 'application/json'};
    bool succeed = true;
    var content;

    try {
      content = await http.patch(endpoint, headers: headers, body: jsonEncode(reqBody));
    } catch (e) {
      print(e);
      succeed = false;
    }

    if (content.statusCode == 500) {
      succeed = false;
    }

    return succeed;
  }

  Future<bool> deletePost(String uuid) async {
    var endpoint = Uri.http('${Config.postApiUrl}', '/post/$uuid');
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

  Future<SinglePost> getPost(String uuid) async {
    var endpoint = Uri.http('${Config.postApiUrl}', '/post/$uuid');
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return compute(parseSinglePost, json.decode(response.body));
  }

  Future<List<FeedPost>> getLocationPosts(String location, [int? page]) async {
    String path = '/post/location/$location';
    var endpoint;
    endpoint = Uri.http('${Config.postApiUrl}', path);
    if (page != null && page > 1) {
      var params = {'offset': page.toString()};
      endpoint = Uri.http('${Config.postApiUrl}', path, params);
    }
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return compute(parseFeedPosts, json.decode(response.body));
  }

  Future<List<FeedPost>> getLocBarPosts(String location, String bar,
      [int? page]) async {
    String path = '/post/locbar/$location/$bar';
    var endpoint;
    endpoint = Uri.http('${Config.postApiUrl}', path);
    if (page != null && page > 1) {
      var params = {'offset': page.toString()};
      endpoint = Uri.http('${Config.postApiUrl}', path, params);
    }
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return compute(parseFeedPosts, json.decode(response.body));
  }

  Future<List<FeedPost>> getLocNbhoodPosts(String location, String nbhood,
      [int? page]) async {
    String path = '/post/locnbhood/$location/$nbhood';
    var endpoint;
    endpoint = Uri.http('${Config.postApiUrl}', path);
    if (page != null && page > 1) {
      var params = {'offset': page.toString()};
      endpoint = Uri.http('${Config.postApiUrl}', path, params);
    }
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return compute(parseFeedPosts, json.decode(response.body));
  }

  Future<List<FeedPost>> getLocUserPosts(String location, String user,
      [int? page]) async {
    String path = '/post/locuser/$location/$user';
    var endpoint;
    endpoint = Uri.http('${Config.postApiUrl}', path);
    if (page != null && page > 1) {
      var params = {'offset': page.toString()};
      endpoint = Uri.http('${Config.postApiUrl}', path, params);
    }
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return compute(parseFeedPosts, json.decode(response.body));
  }

  Future<List<MyPost>> getMyPosts([int? page]) async {
    String path = '/mypost/user';
    String user = FirebaseAuth.instance.currentUser!.displayName!;
    Map<String, String> headers = {'username': user};
    var endpoint;
    endpoint = Uri.http('${Config.postApiUrl}', path);
    if (page != null && page > 1) {
      var params = {'offset': page.toString()};
      endpoint = Uri.http('${Config.postApiUrl}', path, params);
    }
    var response;
    try {
      response = await http.get(endpoint, headers: headers);
    } catch (e) {
      print(e);
    }

    return compute(parseMyPosts, json.decode(response.body));
  }

  Future<List<FeedPost>> getUserPosts(String user, [int? page]) async {
    String path = '/post/user/$user';
    var endpoint;
    endpoint = Uri.http('${Config.postApiUrl}', path);
    if (page != null && page > 1) {
      var params = {'offset': page.toString()};
      endpoint = Uri.http('${Config.postApiUrl}', path, params);
    }
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return compute(parseFeedPosts, json.decode(response.body));
  }
}
