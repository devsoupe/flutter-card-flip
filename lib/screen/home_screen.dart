import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'asset_image_name.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _imageNames = [
    AssetImageName.orange,
    AssetImageName.banana,
    AssetImageName.apple,
    AssetImageName.strawberry,
  ];

  List<String> _randomImageNames = [];
  List<GlobalKey<FlipCardState>> _cardKeys = [];

  int _frontCardCount = 0;
  final List<int> _frontCardIndexes = [];

  @override
  void initState() {
    super.initState();

    reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Wrap(
          spacing: 4,
          runSpacing: 4,
          children: List.generate(
            _randomImageNames.length,
            (index) {
              if (_randomImageNames[index].isEmpty) {
                return Container(
                  width: 90,
                  height: 150,
                  color: Colors.transparent,
                );
              }
              return FlipCard(
                key: _cardKeys[index],
                onFlip: () {
                  _frontCardCount++;
                  _frontCardIndexes.add(index);
                },
                onFlipDone: (bool) {
                  if (_frontCardCount == 2) {
                    _toggleCardToFront();

                    _checkCardIsEqual();

                    _frontCardCount = 0;
                  }
                },
                front: Container(
                  width: 90,
                  height: 150,
                  color: Colors.orange,
                ),
                back: Container(
                  width: 90,
                  height: 150,
                  child: _randomImageNames[index].isEmpty
                      ? null
                      : Image.asset(
                          _randomImageNames[index],
                          fit: BoxFit.cover,
                        ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            reset();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  void _toggleCardToFront() {
    for (var cardKey in _cardKeys) {
      if (!(cardKey.currentState?.isFront ?? false)) {
        cardKey.currentState?.toggleCard();
      }
    }
  }

  void _checkCardIsEqual() {
    if (_frontCardIndexes.length >= 2) {
      String firstCardName = _randomImageNames[_frontCardIndexes[0]];
      String secondCardName = _randomImageNames[_frontCardIndexes[1]];
      if (firstCardName == secondCardName) {
        _randomImageNames[_frontCardIndexes[0]] = '';
        _randomImageNames[_frontCardIndexes[1]] = '';

        setState(() {});
      }
    }

    _frontCardIndexes.clear();
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
}
