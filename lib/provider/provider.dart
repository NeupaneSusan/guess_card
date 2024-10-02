import 'package:flip_card/flip_card.dart';

import 'package:flutter/material.dart';

import '../model/card_model.dart';

class CardProvider with ChangeNotifier {
  List<GlobalKey<FlipCardState>> cardKeys = [];
  List<CardModel> originalArray = [
    CardModel(
        imagePath: 'asset/image/ace_of_clubs.png',
        title: 1,
        isClick: false,
        isMatch: false),
    CardModel(
        imagePath: 'asset/image/ace_of_diamonds.png',
        title: 2,
        isClick: false,
        isMatch: false),
    CardModel(
        imagePath: 'asset/image/ace_of_hearts.png',
        title: 3,
        isClick: false,
        isMatch: false),
    CardModel(
        imagePath: 'asset/image/ace_of_clubs.png',
        title: 1,
        isClick: false,
        isMatch: false),
    CardModel(
        imagePath: 'asset/image/ace_of_diamonds.png',
        title: 2,
        isClick: false,
        isMatch: false),
    CardModel(
        imagePath: 'asset/image/ace_of_hearts.png',
        title: 3,
        isClick: false,
        isMatch: false),
  ];
  List<CardModel> suff = [];

  String _isMatch = '';
  int _indexFirst = -1;
  int _indexSecond = -1;

  bool _isAwait = false;
  bool _isCompelete = false;

  void initial() {
    suff = [];
    _indexFirst = -1;
    suff = originalArray
        .map((cardData) => CardModel(
            title: cardData.title,
            imagePath: cardData.imagePath,
            isClick: false,
            isMatch: false))
        .toList()
      ..shuffle();
    _isMatch = '';

    _isAwait = false;
    _isCompelete = false;
    for (int i = 0; i < originalArray.length; i++) {
      cardKeys.add(GlobalKey<FlipCardState>());
    }
    notifyListeners();
  }

  int get indexFirst => _indexFirst;
  int get indexSecond => _indexSecond;
  bool get isAwait => _isAwait;
  String? get isMatch => _isMatch;
  bool get isCompelete => _isCompelete;
  void onTap(index) {
    if (_indexFirst == -1) {
      _indexFirst = index;
      suff[index].isClick = true;
      notifyListeners();
    } else if (_indexFirst >= 0 &&
        suff[index].title != suff[_indexFirst].title &&
        !_isAwait) {
      _isAwait = true;
      _isMatch = 'notMatch';
      _indexSecond = index;
      notifyListeners();
    } else if (_indexFirst >= 0 &&
        suff[index].title == suff[_indexFirst].title &&
        !_isAwait) {
      isAwait = true;
      suff[index].isMatch = true;
      suff[index].isClick = true;
      suff[_indexFirst].isMatch = true;
      suff[_indexFirst].isClick = true;
      Future.delayed(const Duration(milliseconds: 600), () {
        _indexFirst = -1;
        _indexSecond = -1;
        _isMatch = '';
        _isAwait = false;
        if (suff.every((card) => card.isMatch)) {
          _isCompelete = true;
        }
        notifyListeners();
      });
    }
  }

  void changeNormal() {
    suff[_indexFirst].isClick = false;
    suff[_indexFirst].isMatch = false;
    _indexFirst = -1;
    _indexSecond = -1;
    _isMatch = '';
    _isAwait = false;
    notifyListeners();
  }

  set isAwait(bool value) {
    _isAwait = value;
    Future.delayed(const Duration(milliseconds: 600), () {
      notifyListeners();
    });
  }
}
