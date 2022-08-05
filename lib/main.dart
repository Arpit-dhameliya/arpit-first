import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:onepiconeword/secondpage.dart';

import 'demo.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
  //firstpage()
class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  @override
  void initState() {
    super.initState();
    music();
  }

  music() {


    AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    // assetsAudioPlayer.open(
    //     Playlist(
    //         audios: [
    //           Audio("Audio/arjunreddybgm-57299.mp3"),
    //           Audio("Audio/audiocutter-yt1s-com-vikram-mustafa-57298.mp3"),
    //           Audio(
    //               "Audio/ringtone-jis-vyakti-se-aap-sampark-karna-chahte-hain-vah-filhal-murde-57283-57295.mp3"),
    //           Audio(
    //               "Audio/tujhe-dekha-to-ye-jana-sanam-instrumental-ringtone-57300.mp3"),
    //         ]
    //     ),
    //     loopMode: LoopMode.playlist //loop the full playlist
    // );
    assetsAudioPlayer.playlistPlayAtIndex(0);
    assetsAudioPlayer.next(keepLoopMode: true);

    // AssetsAudioPlayer.newPlayer().open(Audio("Audio/Alone.mp3"),
    //     showNotification: true,
    //     autoStart: true,
    //     loopMode: LoopMode.single,
    //     playInBackground: PlayInBackground.disabledRestoreOnForeground,
    //     pitch:1
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: ,
          body: Column(
        children: [
          Container(
            height: 65,
            color: Colors.deepPurple,
            child: Row(children: [
              SizedBox(width: 10),
              Text(
                "One Pic One Word",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ]),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return onepiconeword();
                        },
                      ));
                    },
                    child: Container(
                        margin: EdgeInsets.all(4),
                        height: 110,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("image/croup_${index + 1}.png"),
                                fit: BoxFit.fill))),
                  );
                },
              ),
            ),
          ),
          // Container(height: 110,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("image/croup_2.png"),fit: BoxFit.fill)),),
          // Container(height: 110,decoration: BoxDecoration(border : Border.all(color: Colors.black,width: 2),image: DecorationImage(image: AssetImage("image/croup_3.png"),fit: BoxFit.fill)),),
          // Container(height: 110,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("image/croup_4.png"),fit: BoxFit.fill)),),
          // Container(height: 110,decoration: BoxDecoration(border : Border.all(color: Colors.black,width: 2),image: DecorationImage(image: AssetImage("image/croup_5.png"),fit: BoxFit.fill)),),
          // Container(height: 110,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("image/croup_6.png"),fit: BoxFit.fill)),),
        ],
      )),
    );
  }
}
