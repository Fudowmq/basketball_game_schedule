import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  int _selectedDayIndex = 2; // Индекс выбранного дня
  int _currentIndex = 2;

  final List<String> days = ['Mon', 'Tue', 'Yesterday', 'Today'];

  // Игры для разных дней
  final Map<String, List<Map<String, dynamic>>> gamesByDay = {
    'Mon': [
      {
        'homeTeam': 'Lakers',
        'awayTeam': 'Spurs',
        'homeScore': 95,
        'awayScore': 117,
        'homeLogoPath': 'assets/images/lakers.png',
        'awayLogoPath': 'assets/images/spurs.png',
      },
      {
        'homeTeam': 'Memphis',
        'awayTeam': 'Minnesota',
        'homeScore': 95,
        'awayScore': 120,
        'homeLogoPath': 'assets/images/memphis.png',
        'awayLogoPath': 'assets/images/minnesota.png',
      },
    ],
    'Today': [
      {
        'homeTeam': 'Bulls',
        'awayTeam': 'Nets',
        'homeScore': 102,
        'awayScore': 99,
        'homeLogoPath': 'assets/images/bulls.png',
        'awayLogoPath': 'assets/images/nets.png',
      },
      {
        'homeTeam': 'Warriors',
        'awayTeam': 'Raptors',
        'homeScore': 118,
        'awayScore': 104,
        'homeLogoPath': 'assets/images/warriors.png',
        'awayLogoPath': 'assets/images/raptors.png',
      },
    ],
    // Добавьте другие дни с играми здесь, если нужно
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24283A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF24283A),
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Games',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Строка для выбора дня
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                children: List.generate(
                  days.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDayIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: _selectedDayIndex == index
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        days[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _selectedDayIndex == index
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Отображение контента в зависимости от выбранного дня
          Expanded(
            child: _selectedDayIndex == 1 // Если выбрал "Tue"
                ? _buildNoGamesMessage()
                : _buildGameList(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildNoGamesMessage() {
    return const Center(
      child: Text(
        'No games on this day',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Виджет для отображения списка игр в зависимости от выбранного дня
  Widget _buildGameList() {
    String selectedDay = days[_selectedDayIndex]; // Получаем выбранный день
    List<Map<String, dynamic>> gamesForDay = gamesByDay[selectedDay] ?? [];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: List.generate(
        gamesForDay.length,
        (index) => _buildGameResult(
          homeTeam: gamesForDay[index]['homeTeam'],
          awayTeam: gamesForDay[index]['awayTeam'],
          homeScore: gamesForDay[index]['homeScore'],
          awayScore: gamesForDay[index]['awayScore'],
          homeLogoPath: gamesForDay[index]['homeLogoPath'],
          awayLogoPath: gamesForDay[index]['awayLogoPath'],
        ),
      ),
    );
  }

  Widget _buildGameResult({
    required String homeTeam,
    required String awayTeam,
    required int homeScore,
    required int awayScore,
    required String homeLogoPath,
    required String awayLogoPath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3B3F54),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(
                    homeLogoPath,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    homeTeam,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '$homeScore - $awayScore',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'FINAL',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    awayLogoPath,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    awayTeam,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
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
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/profile');
            } else if (index == 2) {
              // Логика для выбранной вкладки
            } else if (index == 3) {
              Navigator.pushNamed(context, '/playoff');
            }
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home_icon.svg',
              height: 30,
              color: _currentIndex == 0 ? Colors.white : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/icon_user.svg',
              height: 30,
              color: _currentIndex == 1 ? Colors.white : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/icon_ticket.svg',
              height: 30,
              color: _currentIndex == 2 ? Colors.white : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/icon_playoff.svg',
              height: 30,
              color: _currentIndex == 3 ? Colors.white : Colors.grey,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
