import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import '../core/flip_card_core.dart';

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
  FlipCardCore flipCardCore = FlipCardCore();

  @override
  void initState() {
    super.initState();
    flipCardCore.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<FlipCardCoreEvent>(
          stream: flipCardCore.stream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            } else if (snapshot.data == FlipCardCoreEvent.resetCard || snapshot.data == FlipCardCoreEvent.equalCard) {
              return Center(
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: List.generate(
                    flipCardCore.randomImageNamesSize,
                    (index) {
                      if (flipCardCore.getRandomImageNameIsEmpty(index)) {
                        return Container(
                          width: 90,
                          height: 150,
                          color: Colors.transparent,
                        );
                      }
                      return FlipCard(
                        key: flipCardCore.getCardKey(index),
                        onFlip: () {
                          flipCardCore.flip(index);
                        },
                        onFlipDone: (bool) {
                          flipCardCore.flipDone();
                        },
                        front: Container(
                          width: 90,
                          height: 150,
                          color: Colors.orange,
                        ),
                        back: Container(
                          width: 90,
                          height: 150,
                          child: Image.asset(
                            flipCardCore.getRandomImageName(index),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          flipCardCore.reset();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
