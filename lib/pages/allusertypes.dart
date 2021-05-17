import 'package:flutter/material.dart';
import 'package:NewApp/widget/bottomnav.dart';
import 'package:NewApp/widget/navbarhome.dart';
import 'package:NewApp/services/bardrinkbrandservice.dart';
import 'package:NewApp/widget/useralltypes.dart';
import 'package:strings/strings.dart';
import 'package:NewApp/pages/createuserliked.dart';
import 'package:NewApp/models/userlikedargs.dart';

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
  Future<dynamic>? typeByName;
  int offset = 1;
  int itemsLength = 5;
  bool searched = false;
  String? searchType;

  getAllBars([int? page]) async {
    var response;
    try {
      if (page != null) {
        response = await typeService.getAllBars(page);
      } else {
        response = await typeService.getAllBars();
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

  getAllDrinks([int? page]) async {
    var response;
    try {
      if (page != null) {
        response = await typeService.getAllDrinks(page);
      } else {
        response = await typeService.getAllDrinks();
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

  getAllBrands([int? page]) async {
    var response;
    try {
      if (page != null) {
        response = await typeService.getAllBrands(page);
      } else {
        response = await typeService.getAllBrands();
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

  getBarByName(String name) async {
    var response;
    try {
      response = await typeService.getBarByName(name);
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

  getDrinkByName(String name) async {
    var response;
    try {
      response = await typeService.getDrinkByName(name);
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

  getBrandByName(String name) async {
    var response;
    try {
      response = await typeService.getBrandByName(name);
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
                          Text(
                            'No ${capitalize(widget.type)}s have been created yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                decoration: TextDecoration.underline),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_comment),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, CreateUserLiked.route,
                                  arguments: UserLiked(
                                      type: widget.type, user: widget.user));
                            },
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
                          onPressed: () {},
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
                          Text(
                            'No ${capitalize(widget.type)}s have been created yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                decoration: TextDecoration.underline),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_comment),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, CreateUserLiked.route,
                                  arguments: UserLiked(
                                      type: widget.type, user: widget.user));
                            },
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
                children: [],
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
                          Text(
                            'No ${capitalize(widget.type)}s have been created yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                decoration: TextDecoration.underline),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_comment),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, CreateUserLiked.route,
                                  arguments: UserLiked(
                                      type: widget.type, user: widget.user));
                            },
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
                children: [],
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

  Widget _barByName() {
    return FutureBuilder(
      future: typeByName,
      builder: (context, snapshot) {
        return Container();
      },
    );
  }

  Widget _drinkByName() {
    return FutureBuilder(
      future: typeByName,
      builder: (context, snapshot) {
        return Container();
      },
    );
  }

  Widget _brandByName() {
    return FutureBuilder(
      future: typeByName,
      builder: (context, snapshot) {
        return Container();
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

  Widget _returnType() {
    if (searched) {
      return _typeName();
    } else {
      return _typeAll();
    }
  }

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case 'bar':
        userType = getAllBars();
        break;
      case 'drink':
        userType = getAllDrinks();
        break;
      case 'brand':
        userType = getAllBrands();
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
          _returnType(),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
