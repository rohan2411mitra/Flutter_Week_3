import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl, posterurl, vote, launch_on;

  const Description(
      {Key? key,
        required this.name,
        required this.description,
        required this.bannerurl,
        required this.posterurl,
        required this.vote,
        required this.launch_on})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Description",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

      ),
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(children: [
          Container(
              height: 250,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    child: Text('⭐ Average Rating - ' + vote, style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white))),
              ])),
          SizedBox(height: 15),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(name != null ? name : 'Not Loaded', style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: Colors.white70))),
          Container(
              padding: EdgeInsets.only(left: 10),
              child:
              Text('Releasing On - ' + launch_on, style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: Colors.white70))),
          Row(
            children: [
              Container(
                height: 200,
                width: 100,
                child: Image.network(posterurl),
              ),
              Flexible(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(description, style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70))),
              ),
            ],
          )
        ]),
      ),
    );
  }
}