import 'package:flutter/material.dart';
import 'package:NewApp/pages/home.dart';
import 'package:NewApp/pages/splashscreen.dart';
import 'package:NewApp/pages/createpost.dart';
import 'package:NewApp/pages/myposts.dart';
import 'package:NewApp/pages/signup.dart';
import 'package:NewApp/pages/signin.dart';
import 'package:NewApp/pages/forgotpassword.dart';
import 'package:NewApp/pages/locationposts.dart';
import 'package:NewApp/pages/locbarposts.dart';
import 'package:NewApp/pages/locnbhoodposts.dart';
import 'package:NewApp/pages/locuserposts.dart';
import 'package:NewApp/pages/singlepost.dart';
import 'package:NewApp/pages/verifyemail.dart';
import 'package:NewApp/pages/adduserinfo.dart';
import 'package:NewApp/pages/userposts.dart';
import 'package:NewApp/models/postargs.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // TODO: make error page
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'New App',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
                fontFamily: 'CrimsonText-Bold',
                // This makes the visual density adapt to the platform that you run
                // the app on. For desktop platforms, the controls will be smaller and
                // closer together (more dense) than on mobile platforms.
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              initialRoute: '/',
              routes: {
                '/': (context) => SplashScreen(),
                '/createpost': (context) => CreatePost(),
                '/signup': (context) => SignUp(),
                '/forgot': (context) => ForgotPassword(),
                '/signin': (context) => SignIn(),
                '/verifyemail': (context) => VerifyEmail(),
                '/adduserinfo': (context) => AddUserInfo(),
                '/home': (context) => Home(),
                '/mypost': (context) => MyPosts()
              },
              onGenerateRoute: (RouteSettings settings) {
                //single post scenario
                if (settings.name == SinglePost.route) {
                  final PostArgs args = settings.arguments as PostArgs;
                  return MaterialPageRoute(builder: (context) {
                    return SinglePost(args.uuid, args.currentUser);
                  });
                }
                var routes = <String, WidgetBuilder>{
                  LocationPosts.route: (context) =>
                      LocationPosts(settings.arguments as String),
                  LocBarPosts.route: (context) =>
                      LocBarPosts(settings.arguments as String),
                  LocNbhoodPosts.route: (context) =>
                      LocNbhoodPosts(settings.arguments as String),
                  LocUserPosts.route: (context) =>
                      LocUserPosts(settings.arguments as String),
                  UserPosts.route: (context) =>
                      UserPosts(settings.arguments as String)
                };
                WidgetBuilder builder = routes[settings.name]!;
                return MaterialPageRoute(
                    builder: (context) => builder(context));
              },
            );
          }
          // TODO: return a loading widget
          return Container();
        });
  }
}
