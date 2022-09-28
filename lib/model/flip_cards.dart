import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

import '../screen/asset_image_name.dart';

class FlipCards {
  final _imageNames = [
    AssetImageName.orange,
    AssetImageName.banana,
    AssetImageName.apple,
    AssetImageName.strawberry,
  ];

  List<String> _randomImageNames = [];

  List<GlobalKey<FlipCardState>> _cardKeys = [];

  List<GlobalKey<FlipCardState>> get cardKeys => _cardKeys;

  List<String> get randomImageNames => _randomImageNames;

  void reset() {
    // add 2 times
    _randomImageNames.clear();
    _randomImageNames.addAll(_imageNames);
    _randomImageNames.addAll(_imageNames);

    // shuffle
    _randomImageNames.shuffle();

    // create global key
    _cardKeys.clear();
    _cardKeys.addAll(_randomImageNames.map((_) => GlobalKey<FlipCardState>()));
  }
}
