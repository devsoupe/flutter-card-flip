import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/flip_cards.dart';

part 'flip_cards_event.dart';

part 'flip_cards_state.dart';

class FlipCardsBloc extends Bloc<FlipCardsEvent, FlipCardsState> {
  int _frontCardCount = 0;
  final List<int> _frontCardIndexes = [];

  int get randomImageNamesSize => state.flipCards.randomImageNames.length;

  FlipCardsBloc() : super(FlipCardsState.initial()) {
    on<ResetEvent>(_reset);
    on<FlipEvent>(_flip);
    on<FlipDoneEvent>(_flipDone);
  }

  void _reset(ResetEvent event, Emitter<FlipCardsState> emit) {
    state.flipCards.reset();
    _frontCardCount = 0;
    emit(state.copyWith(flipCards: state.flipCards));
  }

  void _flip(FlipEvent event, Emitter<FlipCardsState> emit) {
    _frontCardCount++;
    _frontCardIndexes.add(event.index);
  }

  void _flipDone(FlipDoneEvent event, Emitter<FlipCardsState> emit) {
    if (_frontCardCount == 2) {
      _toggleCardToFront();
      _checkCardIsEqual(emit);
    }
  }

  void _toggleCardToFront() {
    for (var cardKey in state.flipCards.cardKeys) {
      if (!(cardKey.currentState?.isFront ?? false)) {
        cardKey.currentState?.toggleCard();
      }
    }
  }

  void _checkCardIsEqual(Emitter<FlipCardsState> emit) {
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
