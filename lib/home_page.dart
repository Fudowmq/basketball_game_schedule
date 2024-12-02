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
      home: const HomePage(title: ''),
    );
  }
}

final List<String> hotNewsImages = [
  'assets/images/lebron_hotnews.png',
  'assets/images/ja.jpg',
  'assets/images/steph_carry_hotnews.jpg',
];

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
  int _currentHotNewsIndex = 0; // Для отслеживания текущего изображения
  final PageController _pageController =
      PageController(); // Контроллер для PageView

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _pageController.dispose(); // Освобождаем ресурсы PageController
    super.dispose();
  }

  void playVideo(String videoPath) {
    // Останавливаем текущее видео, если оно воспроизводится
    if (_videoPlayerController != null &&
        _videoPlayerController!.value.isPlaying) {
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
          barrierDismissible: true,
          builder: (context) {
            return Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.black,
              child: AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              ),
            );
          },
        ).then((_) {
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
        'text': 'Ja MASSIVE Dunk',
      },
      {
        'image': 'assets/images/Gordon_poster.png',
        'video': 'assets/video/Aaron_Gordon_poster.mp4',
        'text': 'Gordon insane poster',
      },
      {
        'image': 'assets/images/Carter_poster.png',
        'video': 'assets/video/Vince_Dunk of Death_ .mp4',
        'text': 'Carters "Dunk of Death"',
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
                Image.asset(
                  'assets/images/logo.png',
                  height: 80,
                  width: 80,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/settings.png',
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
            child: Image.asset(
              'assets/images/blue_line.png',
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
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 48, 54, 77)
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: hotNewsImages.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentHotNewsIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              hotNewsImages[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(hotNewsImages.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentHotNewsIndex == index ? 12 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentHotNewsIndex == index
                                ? Colors.white
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 0.5),
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
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection:
                        Axis.horizontal, // Горизонтальная прокрутка
                    itemCount: highlights.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          playVideo(highlights[index]['video']!);
                        },
                        child: Container(
                          width: 120, // Ширина каждого элемента
                          margin: const EdgeInsets.only(
                              right: 16), // Отступ между элементами
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 48, 54, 77)
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                child: getImage(highlights[index]['image']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  highlights[index]['text']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "LIVE GAME",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 48, 54, 77)
                              .withOpacity(0.5),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                "assets/images/Live_game.png",
                                height: 160,
                                width: 650,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Milwaukee Bucks vs Denver Nuggets",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GamesPage()),
                );
              } else if (index == 3) {
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
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/images/home_icon.png',
                    height: 30,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/images/people_icon.png',
                    height: 30,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/images/score_icon.png',
                    height: 30,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/images/playoff_icon.png',
                    height: 30,
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
