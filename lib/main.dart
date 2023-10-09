import 'package:flutter/material.dart';
import 'package:tic_tac_toe_handson/view/borad.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterKaigi 2023 - TicTacToe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FlutterKaigi 2023 - TicTacToe'),
        ),
        body: const Board(),
      ),
    );
  }
}
