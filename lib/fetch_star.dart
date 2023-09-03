import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'dart:convert';
import 'package:percent_indicator/percent_indicator.dart';

import 'signup.dart';
import 'mode.dart';

////// new star.dart ---> draw_star.dart ---> fetch_star.dart//////////

class FetchStar extends StatefulWidget {
  const FetchStar({super.key});

  @override
  State<FetchStar> createState() => _FetchStarState();
}

class _FetchStarState extends State<FetchStar> {
  String imageUrl = 'http://192.168.150.200:5000/image';
  String similarityUrl =
      'http://your_server_ip:your_port'; // Replace with your server URL for similarity score
  int current_Index = 2;
  double similarityScore = 15;

  Future<void> saveImageAndFetchSimilarity() async {
    var imageResponse = await http.get(Uri.parse(imageUrl));
    Directory directory = await getApplicationDocumentsDirectory();
    File imageFile = File(path.join(directory.path, 'image.jpg'));

    // Convert the image format to JPG
    final image = await decodeImageFromList(imageResponse.bodyBytes);
    final jpgImage = await FlutterImageCompress.compressWithList(
      imageResponse.bodyBytes,
      minHeight: 1920,
      minWidth: 1080,
      quality: 90,
      rotate: 0,
    );

    // Save the JPG image to file
    await imageFile.writeAsBytes(jpgImage);

    // Fetch the similarity score
    var similarityResponse = await http.get(Uri.parse(similarityUrl));
    if (similarityResponse.statusCode == 200) {
      final data = json.decode(similarityResponse.body);
      setState(() {
        similarityScore = data['similarity_score'];
        if (similarityScore == 0) {
          similarityScore = 100;
        }
      });
    } else {
      throw Exception('Failed to fetch similarity score');
    }

    // Save the image to the device's gallery
    final result = await ImageGallerySaver.saveFile(imageFile.path);

    if (result['isSuccess']) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Image saved successfully!"),
          content: Column(
            children: [
              Image.file(imageFile),
              Text(
                'Similarity Score: ${similarityScore.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
    } else {
      print('Failed to save image to gallery');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(imageUrl),
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

            //--------------save image button------------------------------//
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: saveImageAndFetchSimilarity,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color(0xFFEE6B0E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  "Save Image",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Manrope',
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            //--------------------save image button---------------//
            Padding(
              padding: const EdgeInsets.only(top: 10),
            ),
            SizedBox(
              child: CircularPercentIndicator(
                radius: 100,
                lineWidth: 20,
                percent: similarityScore / 100,
                progressColor: const Color(0xFFEE6B0E),
                backgroundColor: Colors.grey,
              ),
            ),
            Text(
              'Similarity Score: ${similarityScore}%',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
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
            if (current_Index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => modes()),
              );
            }
          });
        },
      ),
    );
  }
}
