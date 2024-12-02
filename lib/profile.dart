import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 1;

  String _myTeamImage = 'assets/images/my_team_icon.png';

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
            child: Image.asset(
              'assets/images/blue_line.png',
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
                            _myTeamImage, 'My Team', _onMyTeamTap),
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

  // Обработчик нажатия на 'My Team'
  void _onMyTeamTap() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromARGB(255, 48, 54, 77).withOpacity(0.9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Select Your Team',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Добавьте ваши команды здесь
            _buildTeamTile('Atlanta', 'assets/myTeamImages/atlanta.png'),
            _buildTeamTile('Boston', 'assets/myTeamImages/boston.png'),
            _buildTeamTile('Brooklyn', 'assets/myTeamImages/brooklyn.png'),
            _buildTeamTile('Bucks', 'assets/myTeamImages/bucks.png'),
            _buildTeamTile('Bulls', 'assets/myTeamImages/bulls.png'),
            _buildTeamTile('Cleveland', 'assets/myTeamImages/cleveland.png'),
            _buildTeamTile('Clippers', 'assets/myTeamImages/clippers.png'),
            _buildTeamTile('Dallas', 'assets/myTeamImages/dallas.png'),
            _buildTeamTile('Denver', 'assets/myTeamImages/denver.png'),
            _buildTeamTile('Detroit', 'assets/myTeamImages/detroit.png'),
            _buildTeamTile('Hornets', 'assets/myTeamImages/hornets.png'),
            _buildTeamTile('Indiana', 'assets/myTeamImages/indiana.png'),
            _buildTeamTile('Jazz', 'assets/myTeamImages/jazz.png'),
            _buildTeamTile('Kings', 'assets/myTeamImages/kings.png'),
            _buildTeamTile('Knicks', 'assets/myTeamImages/knicks.png'),
            _buildTeamTile('Lakers', 'assets/myTeamImages/lakers.png'),
            _buildTeamTile('Magic', 'assets/myTeamImages/magic.png'),
            _buildTeamTile('Memphis', 'assets/myTeamImages/memphis.png'),
            _buildTeamTile('Miami', 'assets/myTeamImages/miami.png'),
            _buildTeamTile('Pelicans', 'assets/myTeamImages/pelicans.png'),
            _buildTeamTile('Portland', 'assets/myTeamImages/portland.png'),
            _buildTeamTile('Raptors', 'assets/myTeamImages/raptors.png'),
            _buildTeamTile('Rocket', 'assets/myTeamImages/rocket.png'),
            _buildTeamTile('Sixers', 'assets/myTeamImages/sixers.png'),
            _buildTeamTile('Spurs', 'assets/myTeamImages/spurs.png'),
            _buildTeamTile('Suns', 'assets/myTeamImages/suns.png'),
            _buildTeamTile('Thunder', 'assets/myTeamImages/thunder.png'),
            _buildTeamTile('Timberwolves', 'assets/myTeamImages/timberwolves.png'),
            _buildTeamTile('Warriors', 'assets/myTeamImages/warriors.png'),
            _buildTeamTile('Wizards', 'assets/myTeamImages/wizards.png'),
          ],
        );
      },
    );
  }

  // Виджет для команды
  Widget _buildTeamTile(String teamName, String assetPath) {
    return ListTile(
      leading: Image.asset(
        assetPath,
        height: 40,
        width: 40,
      ),
      title: Text(
        teamName,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      onTap: () {
        setState(() {
          _myTeamImage = assetPath; // Установка выбранного изображения
        });
        Navigator.pop(context); // Закрытие окна
      },
    );
  }

  Widget _buildProfileOption(String assetPath, String label,
      [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap,
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
                  height: 30,
                  width: 30,
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
