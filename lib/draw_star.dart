import 'package:app/fetch_star.dart';
import 'package:flutter/material.dart';
import 'mode.dart';
import 'connect.dart';
import 'station.dart';
import 'flask_test.dart';
//import 'package:app/utils.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'home2.dart';
import 'fetch_star.dart';

////// new star.dart ---> draw_star.dart ---> fetch_star.dart//////////

class draw_star extends StatefulWidget {
  const draw_star({super.key});

  @override
  State<draw_star> createState() => _draw_starState();
}

class _draw_starState extends State<draw_star> {
  //final auth = FirebaseAuth.instance;
  int current_Index = 2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'LIGHT CANVAS',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 28.0,
              color: Colors.black,
            ),
          ),
          backgroundColor: const Color(0xFFFFFFFF),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                // auth.signOut().then((value) {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => const Home2()));
                // }).onError((error, stackTrace) {
                //   Utils().toastMessage(error.toString());
                // });
              },
              icon: Image.asset(
                "asset/log-out.png",
                fit: BoxFit.contain,
                width: 500,
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
          elevation: 0.0,
        ),
        backgroundColor: const Color(0xFFEFF3FB),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFEE6B0E),
              ),
              child: Row(children: [
                //first button
                Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(

                        // image: DecorationImage(
                        //   image: AssetImage(
                        //       'asset/user.png',

                        //       ),

                        //   fit: BoxFit.fill,
                        // ),
                        ),
                    child: Image.asset(
                      'asset/user.png',
                      scale: 1.5,
                    )),
                const Text(
                  'Maliha Zerin',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Manrope',
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
            //Select Mode Text
            const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)),
            // const SizedBox(
            //   height: 50,
            //   width: 300,
            //   child: Text(
            //     'Free-Hand Mode',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       fontFamily: 'Manrope',
            //       fontSize: 20.0,
            //       color: Color(0xFF01BFBF),
            //     ),
            //   ),
            // ),

//second button
            Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)),
            SizedBox(
              height: 50,
              width: 300,
              child: Text(
                'Draw This Figure',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Syne',
                  fontSize: 25.0,
                  color: Color(0xDD000000),
                ),
              ),
            ),
            Container(
              // margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              height: 200.0,
              width: 200.0,
              //margin: const EdgeInsets.only(top: 150.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/star_template.jpg'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),

//let's get started button
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FetchStar()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color(0xFFEE6B0E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Display Image",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Manrope',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: current_Index,
            selectedItemColor: Colors.teal,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.bluetooth),
                label: 'Connect',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mode),
                label: 'Select Mode',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.laptop),
                label: 'Station',
              ),
            ],
            onTap: (index) {
              setState(() {
                current_Index = index;
                if (current_Index == 0) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const connect()),
                  // );
                }
                if (current_Index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => modes()),
                  );
                }
                if (current_Index == 2) {
                  //navigate to station page
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const station()),
                  // );
                }
              });
            }),
      ),
    );
  }
}
