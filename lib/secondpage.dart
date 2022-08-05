import 'dart:convert';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class onepiconeword extends StatefulWidget {



  @override
  State<onepiconeword> createState() => _onepiconewordState();
}

class _onepiconewordState extends State<onepiconeword> {
  bool status = false;
  List someImages = [];

  List<String> alphalist = [];
  List answerlist = [];
  List abcdlist = [];
  List Bottomlist = [];
  String imagepath = "";
  String alphabet = "";



  FlutterTts flutterTts = FlutterTts();

  Color currentcolor = Color(0xfff3f03a);
  bool answer = false;

  @override
  void dispose() {
    super.dispose();
    _controllerCenter.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initImages();


    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }


  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 7;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 2; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  Future _initImages() async {
    flutterTts.setSpeechRate(-2);
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('image/'))
        .where((String key) => key.contains('.webp'))
        .toList();

    setState(() {
      someImages =
          imagePaths; //[image/almond.webp, image/ant.webp, image/antenna.webp, image/apple.webp, image/arm.webp, image/bag.webp, image/ball.webp, image/balloon.webp, image/banana.webp, image/bandage.webp, image/bangle.webp, image/bat.webp]
      print(someImages);

      int ran = Random().nextInt(someImages.length);

      imagepath = someImages[ran]; //image/ball.webp

      print(imagepath);

      alphabet = imagepath.split("/")[1].split("\.")[0]; // ball

      print(alphabet);

      alphalist = alphabet.split(""); //[b, a, l, l]

      print(alphalist);

      answerlist = List.filled(alphalist.length, ""); // [ , , , ,]

      String abcd = 'abcdefghijklmnopqrstuvwxyz';

      abcdlist = abcd.split(""); //get list of abcd string

      abcdlist.shuffle();

      Bottomlist = abcdlist.getRange(0, 10 - alphalist.length).toList();
      Bottomlist.addAll(alphalist); //answer add in bottom list
      Bottomlist.shuffle(); //
      print(Bottomlist); // shuffle bottom list

      status = true;
    });
  }

  late ConfettiController _controllerCenter;

  @override
  Widget build(BuildContext context) {
    return status
        ? SafeArea(
            child: Scaffold(
                body: Container(
              height: 600,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: 65,
                    color: Colors.orange,
                    //child: Text("/20"),
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(imagepath))),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    height: 40,
                    child: GridView.builder(
                      itemCount: answerlist.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (answerlist[index] != "") {
                                Bottomlist[map[index]] = answerlist[index];

                                answerlist[index] = "";
                              }
                              if (answerlist.contains("")) {
                                currentcolor = Color(0xfff3f03a);
                              }
                            });
                          },
                          child: Container(
                              height: 100,
                              width: double.infinity,
                              color: currentcolor,
                              alignment: Alignment.center,
                              child: Text(
                                  "${answerlist[index].toString().toUpperCase()}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    height: 80,
                    child: GridView.builder(
                      itemCount: 12,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        if (index == 10) {
                          return IconButton(
                              onPressed: () {
                                flutterTts.speak(alphabet);
                              },
                              icon: Icon(
                                Icons.lightbulb,
                                color: Colors.pink,
                              ));
                        } else if (index == 11) {
                          return IconButton(
                              onPressed: () async {
                                for (int i = 0; i < alphalist.length; i++) {
                                  await Future.delayed(Duration(seconds: 2));
                                  flutterTts.speak(alphalist[i]);
                                }
                              },
                              icon: Icon(
                                Icons.lightbulb,
                                color: Colors.blue,
                              ));
                        } else {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (Bottomlist[index] != "") { 
                                  for (int i = 0; i < answerlist.length; i++) {
                                    if (answerlist[i] == "") {
                                      answerlist[i] = Bottomlist[index];
                                      Bottomlist[index] = "";

                                      // where(answerlist) = from(Bottomlist)
                                      map[i] = index;
                                      print(map);

                                      setState(() {
                                        if (answerlist.contains("")) {
                                          currentcolor = Color(0xfff3f03a);
                                        } else {
                                          if (listEquals(
                                              answerlist, alphalist)) {
                                            currentcolor = Colors.green;

                                            showDialog(
                                              builder: (context) {
                                                return Container(
                                                  height: 200,
                                                  width: 200,
                                                  child: Dialog(
                                                    backgroundColor:
                                                        Color(0xffffff),
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: ConfettiWidget(
                                                            confettiController:
                                                                _controllerCenter,
                                                            blastDirectionality:
                                                                BlastDirectionality
                                                                    .explosive,
                                                            // don't specify a direction, blast randomly
                                                            shouldLoop: true,
                                                            // start again as soon as the animation is finished
                                                            colors: const [
                                                              Colors.green,
                                                              Colors.blue,
                                                              Colors.pink,
                                                              Colors.orange,
                                                              Colors.purple,
                                                              Colors.black87,
                                                              Colors.blueGrey,
                                                              Colors.lightGreenAccent,
                                                              Colors.grey,
                                                            ],
                                                            // manually specify the colors to be used
                                                            createParticlePath:
                                                                drawStar, // define a custom shape/path.
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                              });
                                                              Navigator
                                                                  .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                                  return onepiconeword();
                                                                },
                                                              ));
                                                            },
                                                            child: Text(
                                                                "You are WIN",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        25)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              context: context,
                                            );
                                            _controllerCenter.play();
                                          } else {
                                            currentcolor = Colors.red;
                                          }
                                        }
                                      });
                                      break;
                                    }
                                  }
                                }
                              });
                            },
                            child: Container(
                                height: 100,
                                width: double.infinity,
                                color: Color(0xfff3f03a),
                                alignment: Alignment.center,
                                child: Text(
                                  "${Bottomlist[index].toString().toUpperCase()}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            )),
          )
        : Center(child: CircularProgressIndicator());
  }

  Map map = {};
}
