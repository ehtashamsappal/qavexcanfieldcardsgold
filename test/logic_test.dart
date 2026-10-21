import 'package:flutter_test/flutter_test.dart';
import 'package:qavexcanfieldcardsgold/game/logic.dart';

SolitaireEngine fresh({int seed = 42}) {
  final e = SolitaireEngine(gameConfig());
  e.newGame(seed: seed);
  return e;
}

SolitaireEngine rigged() {
  final e = SolitaireEngine(gameConfig());
  e.tableau = List.generate(gameConfig().piles, (_) => <SolCard>[]);
  e.foundation = List.generate(gameConfig().foundations, (_) => <SolCard>[]);
  e.stock = <SolCard>[];
  e.waste = <SolCard>[];
  e.reserve = List<SolCard?>.filled(gameConfig().reserves, null);
  e.reservePile = <SolCard>[];
  return e;
}
void main() {
  test('canfield deal: 4 singletons, dealt base, 13 reserve, 34 stock', () {
    final e = fresh();
    expect(e.tableau.length, 4);
    for (int i = 0; i < 4; i++) {
      expect(e.tableau[i].length, 1);
      expect(e.tableau[i].last.faceUp, isTrue);
    }
    expect(e.foundation[0].length, 1); // dealt base card
    expect(e.reservePile.length, 13);
    expect(e.stock.length, 34);
    expect(e.isWon, isFalse);
  });

  test('alternating-color descending build is accepted', () {
    final e = rigged();
    e.tableau[0].add(SolCard(1, 6, faceUp: true)); // 6H red
    e.tableau[1].add(SolCard(0, 5, faceUp: true)); // 5S black
    expect(e.moveTableauToTableau(1, 0, 0), isTrue);
    expect(e.tableau[0].length, 2);
    expect(e.tableau[1], isEmpty);
  });

  test('same-color build is rejected', () {
    final e = rigged();
    e.tableau[0].add(SolCard(1, 6, faceUp: true)); // 6H red
    e.tableau[1].add(SolCard(2, 5, faceUp: true)); // 5D red
    expect(e.moveTableauToTableau(1, 0, 0), isFalse);
    expect(e.tableau[1].length, 1);
  });

  test('draw3 moves three cards to waste and undo restores', () {
    final e = fresh();
    expect(e.drawFromStock(), isTrue);
    expect(e.waste.length, 3);
    expect(e.stock.length, 31);
    e.undo();
    expect(e.waste, isEmpty);
    expect(e.stock.length, 34);
  });

  test('hint spots a build onto the dealt base', () {
    final e = rigged();
    e.foundation[0].add(SolCard(0, 4, faceUp: true)); // 4S base
    e.tableau[0].add(SolCard(0, 5, faceUp: true)); // 5S follows the base
    expect(e.hint(), isNotEmpty);
  });
}
