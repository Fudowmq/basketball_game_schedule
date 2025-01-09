import 'package:basketball_game_schedule/database/user_profile.dart';
import 'package:flutter/material.dart';


class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _myTeamImage = 'default_team_image.png';
  String _myPlayerImage = 'default_player_image.png';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    UserProfile? profile = await DBHelper.getUserProfile();
    if (profile != null) {
      setState(() {
        _myTeamImage = profile.teamImage ?? _myTeamImage;
        _myPlayerImage = profile.playerImage ?? _myPlayerImage;
      });
    }
  }

  void _saveUserProfile() async {
    UserProfile profile = UserProfile(
      teamImage: 'new_team_image.png', 
      playerImage: 'new_player_image.png', 
    );
    await DBHelper.saveUserProfile(profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Column(
        children: [
          Image.asset(_myTeamImage),
          Image.asset(_myPlayerImage),
          ElevatedButton(
              onPressed: _saveUserProfile, child: const Text('Save Profile')),
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 1;

  String _myTeamImage = 'assets/images/my_team_icon.png';
  String _myPlayerImage = 'assets/images/my_player_icon.png';
  String _username = 'Adilbek';

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            _username,
                            style: const TextStyle(
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
                      offset: const Offset(-50.0, 22.0), 
                      child: ElevatedButton(
                        onPressed: () => _showEditUsernameDialog(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 36, 40, 58),
                          side: const BorderSide(color: Colors.white, width: 0.6),
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
                            _myPlayerImage, 'My Players', _onMyPlayersTap),
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

void _showEditUsernameDialog() {
  TextEditingController usernameController = TextEditingController(text: _username);

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color.fromARGB(255, 48, 54, 77),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Username',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 36, 40, 58),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _username = usernameController.text;
                      });
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,  
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),

                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

  




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
            _buildTeamTile('Warriors', 'assets/myTeamImages/warriors.png'),
            _buildTeamTile('Wizards', 'assets/myTeamImages/wizards.png'),
          ],
        );
      },
    );
  }


  Widget _buildTeamTile(String teamName, String assetPath) {
    return ListTile(
      leading: Image.asset(
        assetPath,
        height: 45,
        width: 45,
      ),
      title: Text(
        teamName,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      onTap: () async {
        setState(() {
          _myTeamImage = assetPath;
        });
        // Сохранение выбранной команды в базу данных
        await DBHelper.saveUserProfile(UserProfile(
          teamImage: assetPath,
          playerImage: _myPlayerImage,
        ));
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      },
    );
  }

  void _onMyPlayersTap() {
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
              'Select Your Player',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            _buildPlayerTile('LeBron James', 'assets/myPlayerImages/lebron.png'),
            _buildPlayerTile('Stephen Curry', 'assets/myPlayerImages/curry.png'),
            _buildPlayerTile('Kevin Durant', 'assets/myPlayerImages/durant.png'),
            _buildPlayerTile('Luka Dončić', 'assets/myPlayerImages/luka.png'),
            _buildPlayerTile('Nikola Jokić', 'assets/myPlayerImages/jokic.png'),
            _buildPlayerTile('Giannis Antetokounmpo','assets/myPlayerImages/antetokounmpo.png'),
            _buildPlayerTile('Lamelo Ball', 'assets/myPlayerImages/lamelo.png'),
            _buildPlayerTile('Ja Morant', 'assets/myPlayerImages/morant.png'),
            _buildPlayerTile('Victor Wembanyama', 'assets/myPlayerImages/wembanyama.png'),
            _buildPlayerTile('Shai Gilgeous-Alexander', 'assets/myPlayerImages/shai.png'),
            _buildPlayerTile('James Harden', 'assets/myPlayerImages/harden.png'),
            _buildPlayerTile('Anthony Edwards', 'assets/myPlayerImages/ant.png'),
          ],
        );
      },
    );
  }

  Widget _buildPlayerTile(String playerName, String assetPath) {
    return ListTile(
      leading: Image.asset(
        assetPath,
        height: 45,
        width: 45,
      ),
      title: Text(
        playerName,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      onTap: () async {
        setState(() {
          _myPlayerImage = assetPath;
        });
        // Сохранение выбранного игрока в базу данных
        await DBHelper.saveUserProfile(UserProfile(
          teamImage: _myTeamImage,
          playerImage: assetPath,
        ));
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
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
              padding: const EdgeInsets.all(16.9),
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
                  height: 40,
                  width: 40,
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
