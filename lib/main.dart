import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:helloworld/randomWords/RandomWords.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random(); // 新增了这一行
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new RandomWords(),
    );
  }
}
