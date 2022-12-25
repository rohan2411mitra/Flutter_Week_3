import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_password_2/screens/signin_screen.dart';
import 'package:login_password_2/utils/color_utils.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:login_password_2/reusable_widgets/reuse.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apikey = '6712cdc4a4104efba468216aac9a3a4c';
  final String readaccesstoken ='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2NzEyY2RjNGE0MTA0ZWZiYTQ2ODIxNmFhYzlhM2E0YyIsInN1YiI6IjYzYTcxOTVlMDgzNTQ3MDBhMDljZmUxMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kkLi9PVfMBgRIVKY_6viizfXRBQolaooCrUCLVBEYCI';
  List trendingmovies = [];
  List topratedmovies = [];
  List nowplaying = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.movies.getPopular();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map nowplayingresult = await tmdbWithCustomLogs.v3.movies.getNowPlaying();

    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      nowplaying = nowplayingresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("333333"),
                hexStringToColor("444444"),
                hexStringToColor("555555")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: ListView(
            children: [
              ListTile(title: Text(
                "Flutter Movie App",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white70),
              ),tileColor: Colors.white),
              SizedBox(height: 8),
              MoviesBuilder(trendingmovies,"Trending Movies"),
              MoviesBuilder(topratedmovies,"Top Rated Movies"),
              MoviesBuilder(nowplaying,"Now Playing"),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child:
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
                      });},
                    child: Text("LOG OUT",
                      style: const TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.black26;
                          }
                          return Colors.white;
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                  ),
                ),

              )
            ],
          ),
        ));
  }
}
