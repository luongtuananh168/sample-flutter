import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];
  var list = <WordPair>[];

  void initFirst() {
    list.add(current);
    notifyListeners();
  }

  void getNext() {
    current = WordPair.random();
    if (!favorites.contains(current)) {
      list.add(current);
    }
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void addFavorite(WordPair word) {
    if (!favorites.contains(word)) {
      favorites.add(word);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair word) {
    if (favorites.contains(word)) {
      favorites.remove(word);
    }
    notifyListeners();
  }

  void setCurrent(WordPair word) {
    current = word;
    notifyListeners();
  }

  void removeList(WordPair word) {
    if (list.contains(word)) {
      list.remove(word);
      favorites.remove(word);
    }
    notifyListeners();
  }
}
