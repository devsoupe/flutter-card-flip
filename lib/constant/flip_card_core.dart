import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

import '../screen/asset_image_name.dart';


class FlipCardCore {
  final _imageNames = [
    AssetImageName.orange,
    AssetImageName.banana,
    AssetImageName.apple,
    AssetImageName.strawberry,
  ];

  List<String> _randomImageNames = [];

  List<GlobalKey<FlipCardState>> _cardKeys = [];

  List<GlobalKey<FlipCardState>> get cardKeys => _cardKeys;
  int _frontCardCount = 0;
  final List<int> _frontCardIndexes = [];

  List<String> get randomImageNames => _randomImageNames;

  int get frontCardCount => _frontCardCount;

  List<int> get frontCardIndexes => _frontCardIndexes;

  void increaseFrontCardCount() {
    _frontCardCount++;
  }

  void toggleCardToFront() {
    for (var cardKey in _cardKeys) {
      if (!(cardKey.currentState?.isFront ?? false)) {
        cardKey.currentState?.toggleCard();
      }
    }
  }

  void reset() {
    // add 2 times
    _randomImageNames.clear();
    _randomImageNames.addAll(_imageNames);
    _randomImageNames.addAll(_imageNames);

    // shuffle
    _randomImageNames.shuffle();

    // create global key
    _frontCardCount = 0;
    _cardKeys.clear();
    _cardKeys.addAll(_randomImageNames.map((_) => GlobalKey<FlipCardState>()));
  }

  void checkCardIsEqual() {
    if (_frontCardIndexes.length >= 2) {
      String firstCardName = _randomImageNames[_frontCardIndexes[0]];
      String secondCardName = _randomImageNames[_frontCardIndexes[1]];
      if (firstCardName == secondCardName) {
        _randomImageNames[_frontCardIndexes[0]] = '';
        _randomImageNames[_frontCardIndexes[1]] = '';
      }
    }

    _frontCardIndexes.clear();
    _frontCardCount = 0;
  }
}
