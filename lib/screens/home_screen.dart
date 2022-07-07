import 'dart:convert';

import 'package:audio_player/screens/detail_audio_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageList = [
    'assets/img/pic-6.png',
    'assets/img/pic-7.png',
    'assets/img/pic-8.png',
    'assets/img/pic-9.png',
    'assets/img/pic-10.png'
  ];

  List _items = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/audio.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  // Fetch content from the json file
  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Play Music',
            style: TextStyle(
                fontSize: 24, color: Colors.black, fontStyle: FontStyle.italic),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(8),
              child: const CircleAvatar(
                radius: 22,
                // child: Image.asset(
                //   'assets/img/user.jpg',
                //   fit: BoxFit.cover,
                // )
                backgroundImage: AssetImage(
                  'assets/img/user.jpg',
                ),
              ),
            )
          ]),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlayAnimationDuration: const Duration(milliseconds: 100),
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: imageList
                  .map((item) => Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(item),
                          fit: BoxFit.contain,
                        )),
                      ))
                  .toList(),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'My Music',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            // var data = _items[index];
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailAudioPage(
                                            songData: _items[index],
                                          )));
                            },
                            leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage(_items[index]['imagePath'])),
                            title: Text(_items[index]['name']),
                            subtitle: Text(_items[index]['author']),
                            trailing: const Icon(Icons.music_note_rounded),
                          );
                        })),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
