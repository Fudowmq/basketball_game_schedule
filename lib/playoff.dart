import 'package:flutter/material.dart';

class PlayoffPage extends StatefulWidget {
  const PlayoffPage({super.key});

  @override
  State<PlayoffPage> createState() => _PlayoffPageState();
}

class _PlayoffPageState extends State<PlayoffPage> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 40, 58),
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'PLAYOFF', // Изменили текст с PLAU на PLAYOFF
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        automaticallyImplyLeading: false, // Убираем стандартную кнопку "назад"
        centerTitle: false, // Выключаем центрирование заголовка
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'BRACKET',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 36, 40, 58),
                ),
              ),
              const SizedBox(height: 8),
              Image.asset(
                'assets/images/logo_NBA.png',
                height: 40,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/images/playyoff_image.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Градиентный BottomNavigationBar
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
          if (index != _currentIndex) {
            setState(() {
              _currentIndex = index;
            });
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/profile');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/games');
            } else if (index == 3) {}
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
    );
  }
}
