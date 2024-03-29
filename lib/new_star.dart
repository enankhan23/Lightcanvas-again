import 'package:app/freehand.dart';
import 'package:app/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'mode.dart';
import 'signup.dart';
import 'draw_star.dart';

////// new star.dart ---> draw_star.dart ---> fetch_star.dart//////////

class newStar extends StatefulWidget {
  @override
  State<newStar> createState() => _newStarState();
}

class _newStarState extends State<newStar> {
  int current_Index = 2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'LIGHT CANVAS',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 28.0,
              color: Colors.black,
            ),
          ),
          backgroundColor: Color(0xFFFFFFFF),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Image.asset(
                "asset/log-out.png",
                fit: BoxFit.contain,
                width: 500,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => signup()),
                );
              },
            ),
          ],
          elevation: 0.0,
        ),
        backgroundColor: Color(0xFFEFF3FB),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFEE6B0E),
              ),
              child: Row(children: [
                //first button
                Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'asset/user.png',
                      scale: 1.5,
                    ),
                    decoration: BoxDecoration(

                        // image: DecorationImage(
                        //   image: AssetImage(
                        //       'asset/user.png',

                        //       ),

                        //   fit: BoxFit.fill,
                        // ),
                        )),
                Text(
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

//second button
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
//third button
            Container(),

//let's get started button
            Padding(
              padding: EdgeInsets.all(20),
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => (draw_star())),
                  );
                },
                child: Text(
                  "Draw",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Manrope',
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Color(0xFFEE6B0E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
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
                // if (current_Index == 0) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => connect()),
                //   );
                // }
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
                  //   MaterialPageRoute(builder: (context) => station()),
                  // );
                }
              });
            }),
      ),
    );
  }
}
