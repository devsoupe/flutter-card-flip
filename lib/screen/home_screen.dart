import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/flip_cards_bloc.dart';

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
      body: BlocBuilder<FlipCardsBloc, FlipCardsState>(
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
                      context.read<FlipCardsBloc>().add(FlipEvent(index: index));
                    },
                    onFlipDone: (bool) {
                      context.read<FlipCardsBloc>().add(FlipDoneEvent());
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
          context.read<FlipCardsBloc>().add(ResetEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
