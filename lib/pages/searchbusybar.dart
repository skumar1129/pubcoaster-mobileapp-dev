import 'package:flutter/material.dart';
import 'package:NewApp/widget/bottomnav.dart';
import 'package:NewApp/widget/navbarhome.dart';
import 'package:NewApp/widget/navdrawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:NewApp/pages/feedback.dart';
import 'package:NewApp/models/feedbackargs.dart';

class SearchBusyBar extends StatefulWidget {
  final location;
  SearchBusyBar(this.location);
  static const route = '/searchbusybar';
  @override
  _SearchBusyBarState createState() => _SearchBusyBarState();
}

class _SearchBusyBarState extends State<SearchBusyBar> {
  String? barName;
  String? neighborhood;

  searchBusyBarApi() {
    if (barName == null) {
      final snackBar = SnackBar(
          content: Text('Error: fill out the required fields',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (neighborhood == null) {
    } else {}
  }

  openGoogleUrl() async {
    if (barName == null) {
      final snackBar = SnackBar(
          content: Text('Error: fill out the required fields',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (neighborhood == null) {
      String _url = 'https://google.com/search';
      barName = barName!.replaceAll(' ', '-');
      _url += '?q=${widget.location}+$barName';
      await launch(_url);
      Navigator.pushReplacementNamed(context, FeedBack.route,
          arguments: FeedBackArgs(location: widget.location, bar: barName!));
    } else {
      String _url = 'https://google.com/search';
      barName = barName!.replaceAll(' ', '-');
      neighborhood = neighborhood!.replaceAll(' ', '-');
      _url += '?q=${widget.location}+$neighborhood+$barName';
      await launch(_url);
      Navigator.pushReplacementNamed(context, FeedBack.route,
          arguments: FeedBackArgs(
              location: widget.location,
              bar: barName!,
              neighborhood: neighborhood!));
    }
  }

  Widget _searchForm() {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 0),
              child: Center(
                child: Text(
                  'Search how busy a bar in ${widget.location}',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Bar*'),
                onChanged: (value) => {
                  if (mounted)
                    {
                      setState(() => {barName = value})
                    }
                },
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Neighborhood*'),
                onChanged: (value) => {
                  if (mounted)
                    {
                      setState(() => {neighborhood = value})
                    }
                },
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1.5,
            ),
            _buttonRow(),
            const Divider(
              color: Colors.white,
              thickness: 1.5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              searchBusyBarApi();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'See what We say',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)))),
          ),
        ),
        VerticalDivider(
          color: Colors.white,
          thickness: 1.5,
        ),
        Expanded(
            child: ElevatedButton(
          onPressed: () {
            openGoogleUrl();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'See what Google says',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)))),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          NavBar(),
          Padding(
            padding: const EdgeInsets.only(right: 4, left: 4, top: 6),
            child: Container(
              decoration: BoxDecoration(border: Border.all(width: 4)),
              padding: const EdgeInsets.only(right: 4, left: 4, top: 10),
              child: _searchForm(),
            ),
          )
        ],
      ),
      endDrawer: NavDrawer(),
      bottomNavigationBar: BottomNav(),
    );
  }
}
