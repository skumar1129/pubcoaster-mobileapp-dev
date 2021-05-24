import 'package:flutter/material.dart';
import 'package:NewApp/widget/bottomnav.dart';
import 'package:NewApp/widget/navbarhome.dart';
import 'package:NewApp/services/bardrinkbrandservice.dart';
import 'package:NewApp/widget/useralltypes.dart';
import 'package:strings/strings.dart';
import 'package:NewApp/pages/createuserliked.dart';
import 'package:NewApp/models/userlikedargs.dart';

class TypeByName extends StatefulWidget {
  TypeByName(this.type, this.user, this.search);
  final String type;
  final String user;
  final String search;
  static const route = '/typebyname';
  @override
  _TypeByNameState createState() => _TypeByNameState();
}

class _TypeByNameState extends State<TypeByName> {
  Future<dynamic>? typeByName;
  final typeService = new BarDrinkBrandService();
  int offset = 1;
  int itemsLength = 5;
  String? search;

  searchBar() {
    if (search != null) {
      Navigator.pushReplacementNamed(context, TypeByName.route,
          arguments:
              UserLiked(type: widget.type, user: widget.user, search: search));
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
    if (search != null) {
      Navigator.pushReplacementNamed(context, TypeByName.route,
          arguments:
              UserLiked(type: widget.type, user: widget.user, search: search));
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
    if (search != null) {
      Navigator.pushReplacementNamed(context, TypeByName.route,
          arguments:
              UserLiked(type: widget.type, user: widget.user, search: search));
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

  getBarByName(String name, String user, [int? page]) async {
    var response;
    try {
      if (page != null) {
        response = await typeService.getBarByName(name, user);
      } else {
        response = await typeService.getBarByName(name, user, page);
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
          content: Text(
              'Error: could not retrieve bar information. Check network connection.',
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

  getDrinkByName(String name, String user) async {
    var response;
    try {
      response = await typeService.getDrinkByName(name, user);
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
          content: Text(
              'Error: could not retrieve drink information. Check network connection.',
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

  Widget _barByName() {
    return FutureBuilder(
      future: typeByName,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data as List<dynamic>;
          if (items.length == 0) {
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
                            setState(() => {search = value})
                          }
                      },
                    ),
                  ),
                  Text(
                    'No ${capitalize(widget.type)}s were found for ${widget.search}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        decoration: TextDecoration.underline),
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
                            searchBar();
                          },
                        ),
                      ),
                      onChanged: (value) => {
                        if (mounted)
                          {
                            setState(() => {search = value})
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
                                var newBars = getBarByName(
                                    widget.search, widget.user, offset);
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
                                  widget.type, items[index], widget.user);
                            }),
                        onRefresh: () {
                          return getBarByName(widget.search, widget.user);
                        },
                      ),
                    ),
                  ),
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
                      'There was an error getting the ${capitalize(widget.type)}s you searched for',
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

  Widget _drinkByName() {
    return FutureBuilder(
      future: typeByName,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var item = snapshot.data as List<dynamic>;
          if (item.length == 0) {
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
                            setState(() => {search = value})
                          }
                      },
                    ),
                  ),
                  Text(
                    'No ${capitalize(widget.type)}s were found for ${widget.search}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        decoration: TextDecoration.underline),
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
                  SizedBox(height: MediaQuery.of(context).size.height * .14),
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
                            setState(() => {search = value})
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
                            itemCount: item.length,
                            itemBuilder: (context, index) {
                              return UserAllTypes(
                                  widget.type, item[index], widget.user);
                            }),
                        onRefresh: () {
                          return getDrinkByName(widget.search, widget.user);
                        },
                      ),
                    ),
                  ),
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
                      'There was an error getting the ${capitalize(widget.type)}s you searched for',
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

  Widget _brandByName() {
    return FutureBuilder(
      future: typeByName,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var item = snapshot.data as List<dynamic>;
          if (item.length == 0) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            setState(() => {search = value})
                          }
                      },
                    ),
                  ),
                  Text(
                    'No ${capitalize(widget.type)}s were found for ${widget.search}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        decoration: TextDecoration.underline),
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
                  SizedBox(height: MediaQuery.of(context).size.height * .14),
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
                            setState(() => {search = value})
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
                          itemCount: item.length,
                          itemBuilder: (context, index) {
                            return UserAllTypes(
                                widget.type, item[index], widget.user);
                          },
                        ),
                        onRefresh: () {
                          return getBrandByName(widget.search, widget.user);
                        },
                      ),
                    ),
                  ),
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
                      'There was an error getting the ${capitalize(widget.type)}s you searched for',
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

  Widget _typeName() {
    switch (widget.type) {
      case 'bar':
        return _barByName();
      case 'drink':
        return _drinkByName();
      case 'brand':
        return _brandByName();
      default:
        return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case 'bar':
        typeByName = getBarByName(widget.search, widget.user);
        break;
      case 'drink':
        typeByName = getDrinkByName(widget.search, widget.user);
        break;
      case 'brand':
        typeByName = getBrandByName(widget.search, widget.user);
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
          _typeName(),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
