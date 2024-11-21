import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 1;

  double positionOffsetX = 0.0;
  double positionOffsetY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 40, 58),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Adilbek',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Transform.translate(
                      offset: const Offset(-10.0, 22.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Логика для кнопки Manage Profile
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side:
                              const BorderSide(color: Colors.white, width: 0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Manage Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 170.0),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        _buildProfileOption(
                            'assets/images/my_team_icon.png', 'My Team'),
                        _buildProfileOption(
                            'assets/images/my_player_icon.png', 'My Players'),
                        _buildProfileOption(
                            'assets/images/store_icon.png', 'Store'),
                        _buildProfileOption(
                            'assets/images/ticket_icon.png', 'Buy Tickets'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProfileOption(String assetPath, String label) {
    return GestureDetector(
      onTap: () {
        // Логика для обработки нажатия
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: -0.1, 
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 48, 54, 77).withOpacity(0.9),
                    const Color.fromARGB(255, 36, 40, 58).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: Transform.rotate(
                angle: 0.1, 
                child: Image.asset(
                  assetPath,
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
              
            } else if (index == 2) {
              Navigator.pushNamed(context, '/games');
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
              'assets/images/scoreboard.svg',
              height: 30,
              color: _currentIndex == 2 ? Colors.white : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/standings.svg',
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
