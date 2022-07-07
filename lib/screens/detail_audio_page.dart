import 'package:audio_player/screens/audio_file.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DetailAudioPage extends StatefulWidget {
  const DetailAudioPage({Key? key, required this.songData}) : super(key: key);

  final songData;

  @override
  _DetailAudioPageState createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer advancedPlayer;

  @override
  void initState() {
    advancedPlayer = AudioPlayer();
    // advancedPlayer.play(AssetSource(widget.songData['audioPath']));
    // advancedPlayer.play()
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 182, 208, 229),
      body: Stack(children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 3,
            child: Container(
              color: Colors.blue,
            )),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    advancedPlayer.dispose();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
            )),
        Positioned(
            top: screenHeight * 0.2,
            left: 0,
            right: 0,
            height: screenHeight * 0.36,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Text(
                    widget.songData['name'],
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir"),
                  ),
                  Text(
                    widget.songData['author'],
                    style: const TextStyle(fontSize: 20),
                  ),
                  AudioFile(
                    advancedPlayer: advancedPlayer,
                    songFile: widget.songData['audioPath'],
                  ),
                ],
              ),
            )),
        Positioned(
            top: screenHeight * 0.12,
            left: (screenWidth - 130) / 2,
            right: (screenWidth - 130) / 2,
            height: screenHeight * 0.16,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                    image: DecorationImage(
                        image: AssetImage(widget.songData['imagePath']),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ))
      ]),
    );
  }
}
