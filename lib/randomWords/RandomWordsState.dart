import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'RandomWords.dart';

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _save = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),

        // 对于每个建议的单词对都会调用一次 itemBuilder，
        // 然后将单词对添加到 ListTile 行中
        // 在偶数行，该函数会为单词对添加一个 ListTile row.
        // 在奇数行，该函数会添加一个分割线的 widget，来分隔相邻的词对。
        // 注意，在小屏幕上，分割线看起来可能比较吃力。

        itemBuilder: (BuildContext context, int i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) {
            return const Divider();
          }

          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整）
          // 比如 i 为：1, 2, 3, 4, 5 时，结果为 0, 1, 1, 2, 2，
          // 这可以计算出 ListView 中减去分隔线后的实际单词对数量
          final int index = i ~/ 2;
          // 如果是建议列表中最后一个单词对
          if (index >= _suggestions.length) {
            // ...接着再生成10个单词对，然后添加到建议列表
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _save.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _save.remove(pair);
          } else {
            _save.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 代码从这里...
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(onPressed: _pushSaved, icon: const Icon(Icons.list))
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // 新增如下20行代码 ...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _save.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            // 新增 6 行代码开始 ...
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ... 新增代码结束
    );
  }
}
