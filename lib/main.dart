import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/flip_cards_cubit.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => FlipCardsCubit(),
      child: MaterialApp(
        home: HomeScreen(
          title: 'Flip Card',
        ),
      ),
    ),
  );
}
