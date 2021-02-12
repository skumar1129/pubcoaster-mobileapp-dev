import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:NewApp/models/feedpost.dart';
import 'package:NewApp/models/singlepost.dart';
import 'dart:async';

List<FeedPost> parseFeedPosts(dateItems) {
  var response =
      dateItems.map<FeedPost>((json) => FeedPost.fromJson(json)).toList();
  return response;
}

SinglePost parseSinglePost(dataItem) {
  var response = SinglePost.fromJson(dataItem);
  return response;
}

class PostService {
  // TODO: Add auth token in header for all calls (will do when firebase is implemented)

  Future<bool> addPost(item) async {
    String endpoint = '${Config.localUrl}/post';
    // TODO: Add user from local storage
    var reqBody = {
      'username': item['username'],
      'anonymous': item['anonymous'],
      'location': item['location'],
      'bar': item['bar'],
      'rating': item['rating'],
      'neighborhood': item['nbhood'],
      'description': item['description'],
      'pickLink': ''
    };

    bool succeed;
    try {
      await http.post(endpoint, body: jsonEncode(reqBody));
      succeed = true;
    } catch (e) {
      print(e);
      succeed = false;
    }

    return succeed;
  }

  Future<bool> updatePost(String uuid, item) async {
    String endpoint = '${Config.localUrl}/post/$uuid';
    var reqBody = {
      'pickLink': '',
      'neighborhood': item['nbhood'],
      'rating': item['rating'],
      'bar': item['bar'],
      'description': item['description']
    };

    bool succeed;

    try {
      await http.patch(endpoint, body: jsonEncode(reqBody));
      succeed = true;
    } catch (e) {
      print(e);
      succeed = false;
    }

    return succeed;
  }

  Future<bool> deletePost(String uuid) async {
    String endpoint = '${Config.localUrl}/post/$uuid';
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

  Future<SinglePost> getPost(String uuid) async {
    String endpoint = '${Config.localUrl}/post/$uuid';
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return compute(parseSinglePost, response);
  }

  Future<List<FeedPost>> getLocationPosts(String location, [int page]) async {
    String endpoint = '${Config.localUrl}/post/location/$location';
    if (page != null && page > 1) {
      endpoint += '?offset=$page';
    }
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return compute(parseFeedPosts, response);
  }

  Future<List<FeedPost>> getLocBarPosts(
      String location, String bar, int page) async {
    String endpoint = '${Config.localUrl}/post/locbar/$location/$bar';
    if (page != null && page > 1) {
      endpoint += '?offset=$page';
    }
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }
    return response;
  }

  Future<List<FeedPost>> getLocNbhoodPosts(
      String location, String nbhood, int page) async {
    String endpoint = '${Config.localUrl}/post/locnbhood/$location/$nbhood';
    if (page != null && page > 1) {
      endpoint += '?offset=$page';
    }
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return response;
  }

  Future<List<FeedPost>> getLocUserPosts(
      String location, String user, int page) async {
    String endpoint = '${Config.localUrl}/post/locuser/$location/$user';
    if (page != null && page > 1) {
      endpoint += '?offset=$page';
    }
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return response;
  }

  Future<List<FeedPost>> getMyPosts(int page) async {
    String endpoint = '${Config.localUrl}/mypost/user';
    if (page != null && page > 1) {
      endpoint += '?offset=$page';
    }
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return response;
  }

  Future<List<FeedPost>> getUserPosts(String user, int page) async {
    String endpoint = '${Config.localUrl}/post/user/$user';
    if (page != null && page > 1) {
      endpoint += '?offset=$page';
    }
    var response;
    try {
      response = await http.get(endpoint);
    } catch (e) {
      print(e);
    }

    return response;
  }
}
