// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:english_words/english_words.dart';
import 'package:fit_wheel/entry_list.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _entries = EntryList();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _entries.generated.length) {
            var generatedPairs = generateWordPairs().take(10);
            print("Generate pairs: ${generatedPairs}");
            _entries.addAll(generatedPairs);
          }
          return _buildRow(_entries.generated[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadyLiked = _entries.pairIsLiked(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: _biggerFont),
      trailing: Icon(
        alreadyLiked ? Icons.favorite : Icons.favorite_border,
        color: alreadyLiked ? Colors.red : null,
        semanticLabel: alreadyLiked ? "Remove from saved" : "Save",
      ),
      onTap: () {
        print("TAPTAP");
        print(alreadyLiked);
        setState(() {
          if (alreadyLiked) {
            print("dislike ${pair}");
            _entries.dislike(pair);
          } else {
            print("like ${pair}");
            _entries.like(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test App with Persistence layer"),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: "Saved Suggestions",
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      final tiles = _entries.liked.map(
        (pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },
      );
      final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList()
          : <Widget>[];

      return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Suggestions'),
        ),
        body: ListView(children: divided),
      );
    }));
  }
}
