import 'package:flutter/material.dart';
import 'package:NewApp/widget/bottomnav.dart';
import 'package:NewApp/widget/navbarhome.dart';
import 'package:NewApp/services/userservice.dart';
import 'package:strings/strings.dart';

class MyUserLikedType extends StatefulWidget {
  MyUserLikedType(this.type, this.user);
  final String type;
  final String user;
  static const route = '/myuserlikedtype';

  @override
  _MyUserLikedTypeState createState() => _MyUserLikedTypeState();
}

class _MyUserLikedTypeState extends State<MyUserLikedType> {
  final userService = new UserService();
  Future<dynamic>? userLikedType;
  int offset = 1;
  int itemsLength = 5;

  getUserDrink([int? page]) async {
    var response;
    try {
      if (page != null) {
        response = await userService.getUserDrink(widget.user, page);
      } else {
        response = await userService.getUserDrink(widget.user);
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
          content: Text(
              'Error: could not retrieve user information. Check network connection.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  getUserBar([int? page]) async {
    var response;
    try {
      if (page != null) {
        response = await userService.getUserBar(widget.user, page);
      } else {
        response = await userService.getUserBar(widget.user);
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
          content: Text(
              'Error: could not retrieve user information. Check network connection.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  getUserBrand([int? page]) async {
    var response;
    try {
      if (page != null) {
        response = await userService.getUserBrand(widget.user, page);
      } else {
        response = await userService.getUserBrand(widget.user);
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
          content: Text(
              'Error: could not retrieve user information. Check network connection.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  Widget _barsLiked() {
    return FutureBuilder(
      future: userLikedType,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data as List<dynamic>;
          if (items.length == 0) {
            return Expanded(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .1),
                  Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'No liked ${capitalize(widget.type)}s for you yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                decoration: TextDecoration.underline),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_comment),
                            onPressed: () {},
                            color: Colors.red,
                            tooltip: 'Add new liked ${widget.type}',
                          ),
                        ],
                      )),
                  Expanded(
                      child: Image(
                          image: AssetImage('assets/img/city_page.jpg'),
                          height: MediaQuery.of(context).size.height * .4)),
                  SizedBox(height: MediaQuery.of(context).size.height * .14)
                ],
              ),
            );
          } else {
            return Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Your liked ${capitalize(widget.type)}s',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontFamily: 'Oxygen-Bold'),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_comment),
                          onPressed: () {},
                          color: Colors.red,
                          tooltip: 'Add new liked ${widget.type}',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: RefreshIndicator(
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            print(items[index]['barName']);
                            return Container();
                          },
                        ),
                        onRefresh: () {
                          return getUserBar();
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Expanded(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .1),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                      'There was an error getting the liked ${capitalize(widget.type)}s for you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          decoration: TextDecoration.underline)),
                ),
                Expanded(
                    child: Image(
                        image: AssetImage('assets/img/city_page.jpg'),
                        height: MediaQuery.of(context).size.height * .4)),
                SizedBox(height: MediaQuery.of(context).size.height * .14)
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _drinksLiked() {
    return FutureBuilder(
      future: userLikedType,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data as List<dynamic>;
          if (items.length == 0) {
            return Expanded(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .1),
                  Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'No liked ${capitalize(widget.type)}s for you yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                decoration: TextDecoration.underline),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_comment),
                            onPressed: () {},
                            color: Colors.red,
                            tooltip: 'Add new liked ${widget.type}',
                          ),
                        ],
                      )),
                  Expanded(
                      child: Image(
                          image: AssetImage('assets/img/city_page.jpg'),
                          height: MediaQuery.of(context).size.height * .4)),
                  SizedBox(height: MediaQuery.of(context).size.height * .14)
                ],
              ),
            );
          } else {
            return Expanded(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Your liked ${capitalize(widget.type)}s',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontFamily: 'Oxygen-Bold'),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_comment),
                            onPressed: () {},
                            color: Colors.red,
                            tooltip: 'Add new liked ${widget.type}',
                          ),
                        ],
                      )),
                ],
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Expanded(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .1),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                      'There was an error getting the liked ${capitalize(widget.type)}s for you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          decoration: TextDecoration.underline)),
                ),
                Expanded(
                    child: Image(
                        image: AssetImage('assets/img/city_page.jpg'),
                        height: MediaQuery.of(context).size.height * .4)),
                SizedBox(height: MediaQuery.of(context).size.height * .14)
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _brandsLiked() {
    return FutureBuilder(
      future: userLikedType,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data as List<dynamic>;
          if (items.length == 0) {
            return Expanded(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .1),
                  Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                              'No liked ${capitalize(widget.type)}s for you yet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  decoration: TextDecoration.underline)),
                          IconButton(
                            icon: Icon(Icons.add_comment),
                            onPressed: () {},
                            color: Colors.red,
                            tooltip: 'Add new liked ${widget.type}',
                          ),
                        ],
                      )),
                  Expanded(
                      child: Image(
                          image: AssetImage('assets/img/city_page.jpg'),
                          height: MediaQuery.of(context).size.height * .4)),
                  SizedBox(height: MediaQuery.of(context).size.height * .14)
                ],
              ),
            );
          } else {
            return Expanded(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Your liked ${capitalize(widget.type)}s',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontFamily: 'Oxygen-Bold'),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_comment),
                            onPressed: () {},
                            color: Colors.red,
                            tooltip: 'Add new liked ${widget.type}',
                          ),
                        ],
                      )),
                ],
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Expanded(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .1),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                      'There was an error getting the liked ${capitalize(widget.type)}s for you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          decoration: TextDecoration.underline)),
                ),
                Expanded(
                    child: Image(
                        image: AssetImage('assets/img/city_page.jpg'),
                        height: MediaQuery.of(context).size.height * .4)),
                SizedBox(height: MediaQuery.of(context).size.height * .14)
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _displayLikes() {
    switch (widget.type) {
      case 'bar':
        return _barsLiked();
      case 'drink':
        return _drinksLiked();
      case 'brand':
        return _brandsLiked();
      default:
        return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case 'bar':
        userLikedType = getUserBar();
        break;
      case 'drink':
        userLikedType = getUserDrink();
        break;
      case 'brand':
        userLikedType = getUserBrand();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(),
          _displayLikes(),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
