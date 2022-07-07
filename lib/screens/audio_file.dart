import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  const AudioFile(
      {Key? key, required this.advancedPlayer, required this.songFile})
      : super(key: key);

  final AudioPlayer advancedPlayer;
  final songFile;
  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  // String _wavUrl1 = 'https://luan.xyz/files/audio/coins.wav';
  // String _wavUrl2 = 'https://luan.xyz/files/audio/laser.wav';
  // String _mp3Url1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
  // String _mp3Url2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
  //final String url = "https://luan.xyz/files/audio/ambient_c_motion.mp3";
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;
  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled
  ];

  @override
  void initState() {
    super.initState();
    widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    widget.advancedPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    isPlaying = true;

    widget.advancedPlayer.play(AssetSource(widget.songFile));

    // widget.advancedPlayer.setSource(AssetSource('audio/ambient_c_motion.mp3'));

    widget.advancedPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying == false
          ? Icon(
              _icons[0],
              size: 50,
              color: Colors.blue,
            )
          : Icon(
              _icons[1],
              size: 50,
              color: Colors.blue,
            ),
      onPressed: () {
        if (isPlaying == false) {
          widget.advancedPlayer.play(AssetSource(widget.songFile)
              // AssetSource('audio/SoundHelix-Song-1.mp3')
              );
          setState(() {
            isPlaying = true;
            isPaused = false;
          });
        } else if (isPaused == false) {
          widget.advancedPlayer.pause();
          setState(() {
            isPlaying = false;
            isPaused = true;
          });
        }
      },
    );
  }

  Widget btnFast() {
    return IconButton(
        onPressed: () {
          widget.advancedPlayer.setPlaybackRate(1.5);
        },
        icon: const ImageIcon(
          AssetImage('assets/img/forward.png'),
          color: Colors.black,
          size: 15,
        ));
  }

  Widget btnSlow() {
    return IconButton(
        onPressed: () {
          widget.advancedPlayer.setPlaybackRate(0.5);
        },
        icon: const ImageIcon(
          AssetImage('assets/img/backword.png'),
          color: Colors.black,
          size: 15,
        ));
  }

  Widget btnLoop() {
    return IconButton(
        onPressed: () {
          // widget.advancedPlayer.setPlaybackRate(0.5);
        },
        icon: const ImageIcon(
          AssetImage('assets/img/loop.png'),
          color: Colors.black,
          size: 15,
        ));
  }

  Widget btnRepeat() {
    return IconButton(
        onPressed: () {
          if (isRepeat == false) {
            widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
            setState(() {
              isRepeat = true;
              color = Colors.blue;
            });
          } else if (isRepeat == true) {
            widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
            setState(() {
              color = Colors.black;
              isRepeat = false;
            });
          }
          // widget.advancedPlayer.setPlaybackRate(0.5);
        },
        icon: ImageIcon(
          const AssetImage('assets/img/repeat.png'),
          color: color,
          size: 15,
        ));
  }

  Widget loadAssets() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        value: _position.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split(".")[0],
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  _duration.toString().split(".")[0],
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          slider(),
          loadAssets(),
        ],
      ),
    );
  }
}
