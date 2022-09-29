import 'package:flip_card_game/blocs/flip_cards_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screen/home_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => FlipCardsBloc(),
      child: MaterialApp(
        home: HomeScreen(
          title: 'Flip Card',
        ),
      ),
    ),
  );
}
