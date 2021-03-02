import 'dart:convert';
import 'dart:io';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';
import 'package:NewApp/services/postservice.dart';
import 'package:NewApp/services/commentservice.dart';
import 'package:NewApp/services/likeservice.dart';

class SinglePostCard extends StatefulWidget {
  final String bar;
  final String location;
  final String username;
  final int rating;
  final String timestamp;
  final String neighborhood;
  final String editedAt;
  final String picLink;
  final String uuid;
  final bool anonymous;
  final String description;
  final List<dynamic> comments;
  final List<dynamic> likes;
  final String currentUser;

  SinglePostCard(
      this.bar,
      this.location,
      this.username,
      this.rating,
      this.timestamp,
      this.neighborhood,
      this.editedAt,
      this.picLink,
      this.uuid,
      this.description,
      this.anonymous,
      this.comments,
      this.likes,
      this.currentUser
  );

  @override
  _SinglePostCardState createState() => _SinglePostCardState();
}

class _SinglePostCardState extends State<SinglePostCard> {
  String newComment;
  bool editCommentVar = false;
  String editCommentUuid;
  String newEditComment;
  bool userLikedVar;
  final postService = new PostService();
  final commentService = new CommentService();
  final likeService = new LikeService();

  @override
  void initState() {
    super.initState();
    userLikedVar = userLiked();
  }

  likePost() async {
    var item = {
      'username': widget.currentUser,
      'uuid': widget.uuid
    };
    var like = {
      'user': widget.currentUser,
      'like': true
    };
    bool succeed = await likeService.addLike(item);
    if (succeed) {
      setState(() {
        userLikedVar = true;
        widget.likes.add(like);
      });
    }
  }

  unLikePost() async {
    var item = {
      'username': widget.currentUser,
      'uuid': widget.uuid
    };
    var like = {
      'user': widget.currentUser,
      'like': true
    };
    bool succeed = await likeService.deleteLike(item);
    if (succeed) {
      var index = widget.likes.indexOf(like);
      setState(() {
        userLikedVar = false;
        widget.likes.removeAt(index);
      });
    }
  }

  sendComment() async {
    var item = {
      'text': newComment,
    };
    var comment = {
      'text': newComment,
      'createdBy': widget.currentUser,
      'createdAt': //TODO,
      'uuid': //TODO
    };
    bool succeeed = await commentService.updateComment(widget.uuid, item);
    if (succeed) {
      setState(() {
        newComment = "";
      }
      )
    }
  }
  
  editComment(uuid) async {
    setState(() {
      editCommentVar = true;
      editCommentUuid = uuid;
    });
  }

  deleteComment() async {
    bool succeeed = await commentService.deleteComment(widget.uuid);
    if (succeed) {
      var index = widget.comments.indexOf(like);
      setState(() {
        widget.comments.removeAt(index);
      }
      )
    }
  }

  saveComment() async {

  }

  cancelComment() {
    setState(() {
      editCommentVar = false;
      editCommentUuid = "";
      newEditComment = "";
    });
  }
  
  bool userLiked() {
    for(var i=0; i<widget.likes.length; i++) {
      if(widget.likes[i]['user'] == widget.currentUser && widget.likes[i]['like']) {
        return true;
      }
    }
    return false;
  }
  
  Widget likesIcon() {
    return IconButton(
        icon: Icon(Icons.favorite, color: Colors.red),
        onPressed: () { unLikePost(); },
    ); 
  }

  Widget unlikeIcon() {
    return IconButton(
         icon: Icon(Icons.favorite_border, color: Colors.white), 
         onPressed: () { likePost(); },
    ); 
  }
  

  // TODO: Still need logic to determine when a user has liked a post already
  // also need to check the current user like we did for web app

  @override
  Widget build(BuildContext context) {
    String goodContent = utf8.decode(widget.description.codeUnits);
    String goodBar = utf8.decode(widget.bar.codeUnits);
    String goodLocation = utf8.decode(widget.location.codeUnits);
    var newDate = HttpDate.parse(widget.timestamp);
    // TODO: Look into better way to get real time
    var date = newDate.add(Duration(hours: 5));
    return Container(
        height: MediaQuery.of(context).size.height * .6,
        child: Card(
          color: Colors.black,
          child: Column(
            children: [
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              // ListTile(
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      capitalize(goodBar),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Bold',
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      'User Rating: ${widget.rating}/10',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular',
                          fontSize: 15),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              // ),
              const Divider(
                thickness: 1,
                color: Colors.white,
              ),
              (() {
                if (widget.picLink != '') {
                  return Column(children: [
                    Image(image: NetworkImage('${widget.picLink}')),
                    const Divider(
                      thickness: 1,
                      color: Colors.white,
                    )
                  ]);
                } else {
                  return Container();
                }
              }()),
              Text(
                goodContent,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Merriweather-Regular',
                    fontSize: 25),
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              Row(
                children: [
                  (() {
                    if (widget.username != null) {
                      String goodUsername =
                          utf8.decode(widget.username.codeUnits);
                      return Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          '$goodUsername',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'Merriweather-Regular'),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }()),
                  (() {
                    if (widget.likes.length == 0) {
                      return Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Text(
                                'No Likes Yet',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'Merriweather-Regular'),
                              )),
                          (() 
                          { if (userLikedVar) {
                              return likesIcon(); 
                            } else {
                              return unlikeIcon();
                            }
                          }())                          
                        ],
                      );
                    } else if (widget.likes.length == 1) {
                      return Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Text(
                                '${widget.likes.length} like',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'Merriweather-Regular'),
                              )),
                          (() 
                          { if (userLikedVar) {
                              return likesIcon(); 
                            } else {
                              return unlikeIcon();
                            }
                          }())  
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Text(
                                '${widget.likes.length} likes',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'Merriweather-Regular'),
                              )),
                          (() 
                          { if (userLikedVar) {
                              return likesIcon(); 
                            } else {
                              return unlikeIcon();
                            }
                          }())  
                        ],
                      );
                    }
                  }())
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      timeago.format(date.toLocal()),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Italic',
                          fontSize: 18),
                      softWrap: true,
                    ),
                  ),
                  (() {
                    if (widget.neighborhood != null) {
                      String goodNbhood =
                          utf8.decode(widget.neighborhood.codeUnits);
                      return Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Text(
                            '${capitalize(goodNbhood)}, $goodLocation',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Merriweather-Regular',
                                fontSize: 18),
                            softWrap: true,
                          ));
                    } else {
                      return Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Text(
                            '$goodLocation',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Merriweather-Regular'),
                            softWrap: true,
                          ));
                    }
                  }())
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              (() {
                if (widget.comments.length == 0) {
                  return new Row(children: [
                    Center(
                        child: Text(
                      'No comments yet',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ))
                  ]);
                } else {
                  return Expanded(
                      child: ListView.separated(
                          padding: EdgeInsets.all(1),
                          itemCount: widget.comments.length,
                          itemBuilder: (BuildContext context, int index) {
                            var newDate = HttpDate.parse(
                            widget.comments[index]['createdAt']);
                            // TODO: Look into better way to get real time
                            var date = newDate.add(Duration(hours: 5));
                            if (editCommentVar == false || editCommentUuid != widget.comments[index]['uuid']) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Text(
                                    "${widget.comments[index]['createdBy']} : ${widget.comments[index]['text']}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Merriweather-Bold'),
                                  ),
                                ),
                                (() {
                                  if(widget.currentUser == widget.comments[index]['createdBy'] && editCommentVar == false) { //not going to let a user edit multiple comments at once
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 4),
                                          child: Text(
                                          "${timeago.format(date.toLocal())}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Merriweather-Regular'),
                                        )),
                                        IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.red,
                                          ),
                                          tooltip: 'Edit Comment',
                                          onPressed: () { editComment(widget.comments[index]['uuid']); }),
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          tooltip: 'Delete Comment',
                                          onPressed: () { deleteComment(); }),
                                    ],
                                  );
                                 } else {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Text(
                                      "${timeago.format(date.toLocal())}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Merriweather-Regular'),
                                    ));
                                 }
                                }()),
                              ],
                            );
                            } else {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [ //TODO: change
                                  Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text(
                                      "${widget.comments[index]['createdBy']}:  ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Merriweather-Bold'),
                                    ),
                                  ),
                                  Expanded(child:
                                    TextField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelText: 'New Comment Text',
                                        labelStyle: TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8),
                                      ),
                                      onChanged: (String value) {
                                        newEditComment = value;
                                      })
                                    ),
                                    IconButton(
                                      icon: Icon(
                                      Icons.save,
                                      color: Colors.white,
                                    ),
                                    tooltip: 'Save new comment',
                                    onPressed: () { saveComment(); } ),
                                    IconButton(
                                      icon: Icon(
                                      Icons.cancel,
                                      color: Colors.white,
                                    ),
                                    tooltip: 'Cancel new comment',
                                    onPressed: () { cancelComment(); } )
                                ],
                              );
                            }
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                          const Divider(color: Colors.blueGrey)));
                }
              }()),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Create Comment',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        onChanged: (String value) {
                          newComment = value;
                        }),
                  )),
                  IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      tooltip: 'Send comment',
                      onPressed: () { sendComment(); } )
                ],
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              )
            ],
          ),
        ));
  }
}
