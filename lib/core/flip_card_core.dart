import 'dart:async';

import 'package:flip_card_game/model/flip_cards.dart';
import 'package:flutter/material.dart';

enum FlipCardCoreEvent { resetCard, equalCard }

class FlipCardCore {
  final StreamController<FlipCardCoreEvent> _streamController = StreamController();

  Stream<FlipCardCoreEvent>? get stream => _streamController.stream;

  final FlipCards _flipCard = FlipCards();

  int _frontCardCount = 0;
  final List<int> _frontCardIndexes = [];

  int get randomImageNamesSize => _flipCard.randomImageNames.length;

  bool getRandomImageNameIsEmpty(int index) => _flipCard.randomImageNames[index].isEmpty;

  String getRandomImageName(int index) => _flipCard.randomImageNames[index];

  Key getCardKey(int index) => _flipCard.cardKeys[index];

  void reset() {
    _flipCard.reset();
    _frontCardCount = 0;
    _streamController.add(FlipCardCoreEvent.resetCard);
  }

  void _toggleCardToFront() {
    for (var cardKey in _flipCard.cardKeys) {
      if (!(cardKey.currentState?.isFront ?? false)) {
        cardKey.currentState?.toggleCard();
      }
    }
  }

  void flip(int index) {
    _frontCardCount++;
    _frontCardIndexes.add(index);
  }

  void flipDone() {
    if (_frontCardCount == 2) {
      _toggleCardToFront();
      _checkCardIsEqual();
    }
  }

  void _checkCardIsEqual() {
    if (_frontCardIndexes.length >= 2) {
      String firstCardName = _flipCard.randomImageNames[_frontCardIndexes[0]];
      String secondCardName = _flipCard.randomImageNames[_frontCardIndexes[1]];
      if (firstCardName == secondCardName) {
        _flipCard.randomImageNames[_frontCardIndexes[0]] = '';
        _flipCard.randomImageNames[_frontCardIndexes[1]] = '';

        _streamController.add(FlipCardCoreEvent.equalCard);
      }
    }

    _frontCardIndexes.clear();
    _frontCardCount = 0;
  }
}
