import 'package:basketball_game_schedule/games.dart';
import 'package:basketball_game_schedule/home_page.dart';
import 'package:basketball_game_schedule/playoff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'database/database_helper.dart';
import 'database/user.dart';
import 'profile.dart';


void main() async {
  runApp(const BasketballGameSchedule());
}

class BasketballGameSchedule extends StatelessWidget {
  const BasketballGameSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basketball Game Schedule',
      theme: ThemeData(),
      initialRoute: '/', 
      routes: {
        '/': (context) => const MyHomePage(title: ''), 
        '/home': (context) => const HomePage(title: ''),
        '/profile': (context) => const ProfilePage(), 
        '/games': (context) => const GamesPage(),
        '/playoff': (context) => const PlayoffPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<void> _registerUser() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      User? existingUser = await dbHelper.getUser(username);
      if (existingUser == null) {
        await dbHelper.addUser(User(username: username, password: password));
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Аккаунт успешно создан")),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Пользователь уже существует")),
        );
      }
    }
  }

  Future<void> _loginUser() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      User? user = await dbHelper.getUser(username);
      if (user != null && user.password == password) {
        Navigator.pushReplacementNamed(
          // ignore: use_build_context_synchronously
          context,
          '/home', // Навигация на главную страницу
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Неверное имя пользователя или пароль")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 40, 58),
        title: Text(widget.title),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 40, 58),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.0005,
            left: MediaQuery.of(context).size.width * 0.001,
            child: SvgPicture.asset('assets/images/logo.svg'),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            right: 0,
            child: SvgPicture.asset(
              'assets/images/blueLine.svg',
              color: Colors.blue,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 120),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 29, 32, 47).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          suffixIcon:
                              const Icon(Icons.person, color: Colors.white54),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          labelStyle: const TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon:
                              const Icon(Icons.lock, color: Colors.white54),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          labelStyle: const TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _loginUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 36, 40, 58),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 11),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text('LOGIN',
                                style: TextStyle(color: Colors.white)),
                          ),
                          ElevatedButton(
                            onPressed: _registerUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 11),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text('SIGN UP',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
