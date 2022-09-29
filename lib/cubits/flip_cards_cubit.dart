import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/flip_cards.dart';

part 'flip_cards_state.dart';

class FlipCardsCubit extends Cubit<FlipCardsState> {
  int _frontCardCount = 0;
  final List<int> _frontCardIndexes = [];

  int get randomImageNamesSize => state.flipCards.randomImageNames.length;

  FlipCardsCubit() : super(FlipCardsState.initial());

  void reset() {
    state.flipCards.reset();
    _frontCardCount = 0;
    emit(state.copyWith(flipCards: state.flipCards));
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

  void _toggleCardToFront() {
    for (var cardKey in state.flipCards.cardKeys) {
      if (!(cardKey.currentState?.isFront ?? false)) {
        cardKey.currentState?.toggleCard();
      }
    }
  }

  void _checkCardIsEqual() {
    if (_frontCardIndexes.length >= 2) {
      String firstCardName = state.flipCards.randomImageNames[_frontCardIndexes[0]];
      String secondCardName = state.flipCards.randomImageNames[_frontCardIndexes[1]];
      if (firstCardName == secondCardName) {
        state.flipCards.randomImageNames[_frontCardIndexes[0]] = '';
        state.flipCards.randomImageNames[_frontCardIndexes[1]] = '';

        emit(state.copyWith(flipCards: state.flipCards));
      }
    }

    _frontCardIndexes.clear();
    _frontCardCount = 0;
  }
}
