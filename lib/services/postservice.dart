import 'config.dart';
import 'package:NewApp/models/feedpost.dart';
import 'package:NewApp/models/singlepost.dart';
import 'dart:async';

class PostService {
  // TODO: Add auth token in header for all calls (will do when firebase is implemented)

  Future<bool> addPost(item) async {
    String endpoint = '${Config.localUrl}/post';
  }

  Future<bool> updatePost(String uuid) async {
    String endpoint = '${Config.localUrl}/post/$uuid';
  }

  Future<bool> deletePost(String uuid) async {
    String endpoint = '${Config.localUrl}/post/$uuid';
  }

  Future<SinglePost> getPost(String uuid) async {
    String endpoint = '${Config.localUrl}/post/$uuid';
  }

  Future<List<FeedPost>> getLocationPosts(String location, [int page]) async {
    String endpoint = '${Config.localUrl}/post/location/$location';
    if (page != null && page > 1) {
      endpoint += '?offset=$page';
    }
  }

  Future<List<FeedPost>> getLocBarPosts(
      String location, String bar, int page) async {
    String endpoint = '${Config.localUrl}/post/locbar/$location/$bar';
    if (page != null && page > 1) {
      endpoint += '?offset=$page';
    }
  }

  Future<List<FeedPost>> getLocNbhoodPosts(
      String location, String nbhood, int page) async {
    String endpoint = '${Config.localUrl}/post/locnbhood/$location/$nbhood';
    if (page != null && page > 1) {
      endpoint += '?offset=$page';
    }
  }

  Future<List<FeedPost>> getLocUserPosts(
      String location, String user, int page) async {
    String endpoint = '${Config.localUrl}/post/locuser/$location/$user';
    if (page != null && page > 1) {
      endpoint += '?offset=$page';
    }
  }

  Future<List<FeedPost>> getMyPosts(int page) async {
    String endpoint = '${Config.localUrl}/mypost/user';
    if (page != null && page > 1) {
      endpoint += '?offset=$page';
    }
  }

  Future<List<FeedPost>> getUserPosts(String user, int page) async {
    String endpoint = '${Config.localUrl}/post/user/$user';
    if (page != null && page > 1) {
      endpoint += '?offset=$page';
    }
  }
}
