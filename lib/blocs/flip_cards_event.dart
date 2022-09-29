part of 'flip_cards_bloc.dart';

@immutable
abstract class FlipCardsEvent {
  const FlipCardsEvent();
}

class ResetEvent extends FlipCardsEvent {}

class FlipEvent extends FlipCardsEvent {
  final int index;

  const FlipEvent({
    required this.index,
  });
}

class FlipDoneEvent extends FlipCardsEvent {}
