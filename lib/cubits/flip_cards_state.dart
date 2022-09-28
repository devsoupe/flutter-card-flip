part of 'flip_cards_cubit.dart';

class FlipCardsState {
  final FlipCards flipCards;

  const FlipCardsState({
    required this.flipCards,
  });

  factory FlipCardsState.initial() {
    return FlipCardsState(flipCards: FlipCards()..reset());
  }

  @override
  String toString() {
    return 'FlipCardsState{flipCards: $flipCards}';
  }

  FlipCardsState copyWith({
    FlipCards? flipCards,
  }) {
    return FlipCardsState(
      flipCards: flipCards ?? this.flipCards,
    );
  }
}
