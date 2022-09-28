import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/flip_cards_cubit.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<FlipCardsCubit, FlipCardsState>(
        builder: (context, state) {
          return Center(
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              children: List.generate(
                state.flipCards.randomImageNames.length,
                (index) {
                  if (state.flipCards.randomImageNames[index].isEmpty) {
                    return Container(
                      width: 90,
                      height: 150,
                      color: Colors.transparent,
                    );
                  }
                  return FlipCard(
                    key: state.flipCards.cardKeys[index],
                    onFlip: () {
                      context.read<FlipCardsCubit>().flip(index);
                    },
                    onFlipDone: (bool) {
                      context.read<FlipCardsCubit>().flipDone();
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
                        state.flipCards.randomImageNames[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<FlipCardsCubit>().reset();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
