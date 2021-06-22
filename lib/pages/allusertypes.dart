import 'package:flutter/material.dart';
import 'package:NewApp/widget/bottomnav.dart';
import 'package:NewApp/widget/navbarhome.dart';
import 'package:NewApp/services/bardrinkbrandservice.dart';
import 'package:NewApp/widget/useralltypes.dart';
import 'package:strings/strings.dart';
import 'package:NewApp/pages/createuserliked.dart';
import 'package:NewApp/models/userlikedargs.dart';
import 'package:NewApp/pages/typebyname.dart';

class AllUserTypes extends StatefulWidget {
  AllUserTypes(this.type, this.user);
  final String type;
  final String user;
  static const route = '/allusertypes';

  @override
  _AllUserTypesState createState() => _AllUserTypesState();
}

class _AllUserTypesState extends State<AllUserTypes> {
  final typeService = new BarDrinkBrandService();
  Future<dynamic>? userType;
  int offset = 1;
  int itemsLength = 5;
  String? searchType;

  getAllBars(String user, [int? page]) async {
    var response;
    try {
      if (page != null) {
        response = await typeService.getAllBars(user, page);
      } else {
        response = await typeService.getAllBars(user);
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
          content: Text(
              'Error: could not retrieve bars information. Check network connection.',
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

  getAllDrinks(String user, [int? page]) async {
    var response;
    try {
      if (page != null) {
        response = await typeService.getAllDrinks(user, page);
      } else {
        response = await typeService.getAllDrinks(user);
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
          content: Text(
              'Error: could not retrieve drinks information. Check network connection.',
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

  getAllBrands(String user, [int? page]) async {
    var response;
    try {
      if (page != null) {
        response = await typeService.getAllBrands(user, page);
      } else {
        response = await typeService.getAllBrands(user);
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
          content: Text(
              'Error: could not retrieve brands information. Check network connection.',
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

  getBrandByName(String name, String user) async {
    var response;
    try {
      response = await typeService.getBrandByName(name, user);
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
          content: Text(
              'Error: could not retrieve brand information. Check network connection.',
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

  searchBar() {
    if (searchType != null) {
      Navigator.pushReplacementNamed(context, TypeByName.route,
          arguments: UserLiked(
              type: widget.type, user: widget.user, search: searchType));
    } else {
      final snackBar = SnackBar(
          content: Text('Fill out the field please',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  searchBrand() {
    if (searchType != null) {
      Navigator.pushReplacementNamed(context, TypeByName.route,
          arguments: UserLiked(
              type: widget.type, user: widget.user, search: searchType));
    } else {
      final snackBar = SnackBar(
          content: Text('Fill out the field please',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  searchDrink() {
    if (searchType != null) {
      Navigator.pushReplacementNamed(context, TypeByName.route,
          arguments: UserLiked(
              type: widget.type, user: widget.user, search: searchType));
    } else {
      final snackBar = SnackBar(
          content: Text('Fill out the field please',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget _allBars() {
    return FutureBuilder(
      future: userType,
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
                          Expanded(
                            child: Text(
                              'No ${capitalize(widget.type)}s have been created yet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      child: Image(
                          image: AssetImage('assets/img/city_page.jpg'),
                          height: MediaQuery.of(context).size.height * .4)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, CreateUserLiked.route,
                          arguments:
                              UserLiked(type: widget.type, user: widget.user));
                    },
                    child: Text('Create new ${widget.type} to like'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)))),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .14)
                ],
              ),
            );
          } else {
            return Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)),
                        labelText: 'Search ${widget.type}s',
                        labelStyle: TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          color: Colors.black,
                          onPressed: () {
                            searchBar();
                          },
                        ),
                      ),
                      onChanged: (value) => {
                        if (mounted)
                          {
                            setState(() => {searchType = value})
                          }
                      },
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: RefreshIndicator(
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: items.length + 1,
                          itemBuilder: (context, index) {
                            if (index == items.length &&
                                items.length < itemsLength) {
                              return Container();
                            } else if (index == items.length &&
                                items.length >= itemsLength) {
                              itemsLength += 5;
                              offset++;
                              var newBars = getAllBars(widget.user, offset);
                              newBars.then((item) {
                                if (item != null) {
                                  if (mounted) {
                                    setState(() {
                                      items.addAll(item);
                                    });
                                  }
                                }
                              });
                              return IntrinsicWidth(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return UserAllTypes(
                                'bar', items[index], widget.user);
                          },
                        ),
                        onRefresh: () {
                          return getAllBars(widget.user);
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, CreateUserLiked.route,
                          arguments:
                              UserLiked(type: widget.type, user: widget.user));
                    },
                    child: Text('Create new ${widget.type} to like'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)))),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05)
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
                      'There was an error getting the ${capitalize(widget.type)}s',
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

  Widget _allDrinks() {
    return FutureBuilder(
      future: userType,
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
                          Expanded(
                            child: Text(
                              'No ${capitalize(widget.type)}s have been created yet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      )),
                  Expanded(
                      child: Image(
                          image: AssetImage('assets/img/city_page.jpg'),
                          height: MediaQuery.of(context).size.height * .4)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, CreateUserLiked.route,
                          arguments:
                              UserLiked(type: widget.type, user: widget.user));
                    },
                    child: Text('Create new ${widget.type} to like'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)))),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .14)
                ],
              ),
            );
          } else {
            return Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)),
                        labelText: 'Search ${widget.type}s',
                        labelStyle: TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          color: Colors.black,
                          onPressed: () {
                            searchDrink();
                          },
                        ),
                      ),
                      onChanged: (value) => {
                        if (mounted)
                          {
                            setState(() => {searchType = value})
                          }
                      },
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: RefreshIndicator(
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: items.length + 1,
                          itemBuilder: (context, index) {
                            if (index == items.length &&
                                items.length < itemsLength) {
                              return Container();
                            } else if (index == items.length &&
                                items.length >= itemsLength) {
                              itemsLength += 5;
                              offset++;
                              var newDrinks = getAllDrinks(widget.user, offset);
                              newDrinks.then((item) {
                                if (item != null) {
                                  if (mounted) {
                                    setState(() {
                                      items.addAll(item);
                                    });
                                  }
                                }
                              });
                              return IntrinsicWidth(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return UserAllTypes(
                                'drink', items[index], widget.user);
                          },
                        ),
                        onRefresh: () {
                          return getAllDrinks(widget.user);
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, CreateUserLiked.route,
                          arguments:
                              UserLiked(type: widget.type, user: widget.user));
                    },
                    child: Text('Create new ${widget.type} to like'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)))),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05)
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
                      'There was an error getting the ${capitalize(widget.type)}s',
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

  Widget _allBrands() {
    return FutureBuilder(
      future: userType,
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
                        Expanded(
                          child: Text(
                            'No ${capitalize(widget.type)}s have been created yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Image(
                          image: AssetImage('assets/img/city_page.jpg'),
                          height: MediaQuery.of(context).size.height * .4)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, CreateUserLiked.route,
                          arguments:
                              UserLiked(type: widget.type, user: widget.user));
                    },
                    child: Text('Create new ${widget.type} to like'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)))),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .14)
                ],
              ),
            );
          } else {
            return Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)),
                        labelText: 'Search ${widget.type}s',
                        labelStyle: TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          color: Colors.black,
                          onPressed: () {
                            searchBrand();
                          },
                        ),
                      ),
                      onChanged: (value) => {
                        if (mounted)
                          {
                            setState(() => {searchType = value})
                          }
                      },
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: RefreshIndicator(
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: items.length + 1,
                          itemBuilder: (context, index) {
                            if (index == items.length &&
                                items.length < itemsLength) {
                              return Container();
                            } else if (index == items.length &&
                                items.length >= itemsLength) {
                              itemsLength += 5;
                              offset++;
                              var newBrands = getAllBrands(widget.user, offset);
                              newBrands.then((item) {
                                if (item != null) {
                                  if (mounted) {
                                    setState(() {
                                      items.addAll(item);
                                    });
                                  }
                                }
                              });
                              return IntrinsicWidth(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return UserAllTypes(
                                'brand', items[index], widget.user);
                          },
                        ),
                        onRefresh: () {
                          return getAllBrands(widget.user);
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, CreateUserLiked.route,
                          arguments:
                              UserLiked(type: widget.type, user: widget.user));
                    },
                    child: Text('Create new ${widget.type} to like'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)))),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05)
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
                      'There was an error getting the ${capitalize(widget.type)}s',
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

  Widget _typeAll() {
    switch (widget.type) {
      case 'bar':
        return _allBars();
      case 'drink':
        return _allDrinks();
      case 'brand':
        return _allBrands();
      default:
        return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case 'bar':
        userType = getAllBars(widget.user);
        break;
      case 'drink':
        userType = getAllDrinks(widget.user);
        break;
      case 'brand':
        userType = getAllBrands(widget.user);
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
          _typeAll(),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
