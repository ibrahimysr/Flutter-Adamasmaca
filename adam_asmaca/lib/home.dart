import 'dart:math';

import 'package:adam_asmaca/login.dart';
import 'package:adam_asmaca/ui/colors.dart';
import 'package:adam_asmaca/ui/widget/figuri_image.dart';
import 'package:adam_asmaca/ui/widget/letter.dart';
import 'package:adam_asmaca/utils.dart';
import 'package:flutter/material.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  //String word = "flutter".toUpperCase();

  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  static List<String> kelimeler = [
    "dart",
    "flutter",
    "java",
    "kotlin",
    "python",
  ];
  static var index = 0;
  var word = kelimeler[index].toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text("Adam Asmaca"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                //adam asmacadaki fotograflar
                figureImage(
                  Game.tries >= 0,
                  "assets/hang.png",
                ),
                figureImage(
                  Game.tries >= 1,
                  "assets/head.png",
                ),
                figureImage(
                  Game.tries >= 2,
                  "assets/body.png",
                ),
                figureImage(
                  Game.tries >= 3,
                  "assets/ra.png",
                ),
                figureImage(
                  Game.tries >= 4,
                  "assets/la.png",
                ),
                figureImage(
                  Game.tries >= 5,
                  "assets/rl.png",
                ),
                figureImage(
                  Game.tries >= 6,
                  "assets/ll.png",
                ),
              ],
            ),
          ),

          //kelimeyi kutulara bölüp gizleme
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: word
                .split('')
                .map((e) => harf(e.toUpperCase(),
                    !Game.selectedChar.contains(e.toUpperCase())))
                .toList(),
          ),

          //klavyeyi oluşturma
          SizedBox(
            width: double.infinity,
            height: 250.0,
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: const EdgeInsets.all(8.0),
              children: alphabets.map((e) {
                return RawMaterialButton(
                    onPressed: Game.selectedChar.contains(e)
                        ? null // kelimenin kullanılıp kullanılmadıgını kontrol ediyoruz
                        : () {
                            setState(() {
                              Game.selectedChar.add(e);
                              print(Game.selectedChar);
                              if (!word.split('').contains(e.toUpperCase())) {
                                Game.tries++;
                                if (Game.tries == 6) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.black,
                                          title: const Text(
                                            "Oyun Bitti",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          content: const Text("Tekrar Başla",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          actions: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red),
                                                onPressed: () {
                                                  setState(() {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    "İyi Tahminler")));

                                                    index = Random().nextInt(6);
                                                    Navigator.pop(context);
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LoginScreen()));

                                                    Game.selectedChar.clear();
                                                    Game.tries = 0;

                                                  });
                                                },
                                                child: const Text("Evet",
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ],
                                        );
                                      });
                                }
                              }
                            });
                          },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      e,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    fillColor: Game.selectedChar.contains(e)
                        ? Colors.red.shade900
                        : Colors.white);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
