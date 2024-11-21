import 'package:basketball_game_schedule/games.dart';
import 'package:basketball_game_schedule/playoff.dart';
import 'package:basketball_game_schedule/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory, 
        highlightColor: Colors.transparent, 
      ),
      home: const HomePage(title: 'Basketball Highlights'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoPlayerController? _videoPlayerController;
  int _currentIndex = 0; // Для отслеживания текущего индекса

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

void playVideo(String videoPath) {
  // Останавливаем текущее видео, если оно воспроизводится
  if (_videoPlayerController != null && _videoPlayerController!.value.isPlaying) {
    _videoPlayerController!.pause();
  }

  // Инициализируем и запускаем новое видео
  _videoPlayerController = VideoPlayerController.asset(videoPath)
    ..initialize().then((_) {
      setState(() {
        _videoPlayerController!.play();
      });
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        barrierDismissible: true, // Закрытие диалога при нажатии за его пределами
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.zero, // Без отступов
            backgroundColor: Colors.black,
            child: AspectRatio(
              aspectRatio: _videoPlayerController!.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController!),
            ),
          );
        },
      ).then((_) {
        // Ставим видео на паузу при закрытии диалога
        _videoPlayerController!.pause();
      });
    });
}


  Widget getImage(String imagePath) {
    if (imagePath.endsWith('.svg')) {
      return SvgPicture.asset(
        imagePath,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> highlights = [
      {
        'image': 'assets/images/ja_poster.png',
        'video': 'assets/video/Ja Morant Dunk.mp4',
      },
      {
        'image': 'assets/images/Gordon_poster.png',
        'video': 'assets/video/Aaron_Gordon_poster.mp4',
      },
      {
        'image': 'assets/images/Carter_poster.png',
        'video': 'assets/video/Vince_Dunk of Death_ .mp4',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 54, 77),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  height: 60,
                  width: 60,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/images/settings.svg',
                height: 20,
                width: 20,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromARGB(255, 36, 40, 58),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            right: 0,
            child: SvgPicture.asset(
              'assets/images/blueLine.svg',
              color: Colors.blue,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "HOT NEWS",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 200,
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 48, 54, 77).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/ja.jpg",
                      fit: BoxFit.cover,
                      height: 170,
                      width: 310,
                    ),
                  ),
                ),
                const SizedBox(height: 1),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "GAME HIGHLIGHTS",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: highlights.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          playVideo(highlights[index]['video']!);
                        },
                        child: Container(
                          width: 110,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 48, 54, 77)
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: getImage(highlights[index]['image']!),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 48, 54, 77)
                          .withOpacity(0.5),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        "assets/images/Live_game.png",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 0.1),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 48, 54, 77),
                Color.fromARGB(255, 36, 40, 58),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            enableFeedback: false,
            elevation: 0,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });

              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(title: ''),
                  ),
                );
              } else if(index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              } else if(index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GamesPage()),
                );
              } else if(index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlayoffPage()),
                );
              }
            },
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            iconSize: 28,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: SvgPicture.asset(
                    'assets/images/home_icon.svg',
                    height: 30,
                    color: _currentIndex == 0 ? Colors.white : Colors.grey,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: SvgPicture.asset(
                    'assets/images/icon_user.svg',
                    height: 30,
                    color: _currentIndex == 1 ? Colors.white : Colors.grey,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: SvgPicture.asset(
                    'assets/images/scoreboard.svg',
                    height: 30,
                    color: _currentIndex == 2 ? Colors.white : Colors.grey,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: SvgPicture.asset(
                    'assets/images/standings.svg',
                    height: 30,
                    color: _currentIndex == 3 ? Colors.white : Colors.grey,
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}