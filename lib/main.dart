import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:helloworld/randomWords/RandomWords.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red),
      title: 'Welcome to Flutter',
      home: RandomWords(),
    );
  }
}
