import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const BasketballGameSchedule());
}

class BasketballGameSchedule extends StatelessWidget {
  const BasketballGameSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basketball Game Schedule',
      theme: ThemeData(),
      home: const MyHomePage(title: ''),
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
            top: MediaQuery.of(context).size.height * 0.1,  
            left: MediaQuery.of(context).size.width * 0.001, 
            child: SvgPicture.asset('assets/images/logo.svg'),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            right: 0, 
            child: SvgPicture.asset('assets/images/blueLine.svg'),
          ),
        ],
      ),
    );
  }
}