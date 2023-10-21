import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_handson/model/tic_tac_toe.dart';
import 'package:tic_tac_toe_handson/provider/tic_tac_toe_provider.dart';

void main() {
  late StateController<TicTacToe> target;

  setUp(() {
    final container = ProviderContainer();
    target = container.read(ticTacToeProvider.notifier);
  });

  test("resetBoard test - row: 0, col: 0", () {
    target.state = target.state.placeMark(0, 0);
    expect(target.state.board, [
      ['X', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
    target.state = target.state.resetBoard();
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
  });

  test("resetBoard test - row: 0, col: 1", () {
    target.state = target.state.placeMark(0, 1);
    expect(target.state.board, [
      ['', 'X', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
    target.state = target.state.resetBoard();
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
  });

  test("resetBoard test - row: 0, col: 2", () {
    target.state = target.state.placeMark(0, 2);
    expect(target.state.board, [
      ['', '', 'X'],
      ['', '', ''],
      ['', '', ''],
    ]);
    target.state = target.state.resetBoard();
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
  });

  test("resetBoard test - row: 1, col: 0", () {
    target.state = target.state.placeMark(1, 0);
    expect(target.state.board, [
      ['', '', ''],
      ['X', '', ''],
      ['', '', ''],
    ]);
    target.state = target.state.resetBoard();
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
  });

  test("resetBoard test - row: 1, col: 1", () {
    target.state = target.state.placeMark(1, 1);
    expect(target.state.board, [
      ['', '', ''],
      ['', 'X', ''],
      ['', '', ''],
    ]);
    target.state = target.state.resetBoard();
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
  });

  test("resetBoard test - row: 1, col: 2", () {
    target.state = target.state.placeMark(1, 2);
    expect(target.state.board, [
      ['', '', ''],
      ['', '', 'X'],
      ['', '', ''],
    ]);
    target.state = target.state.resetBoard();
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
  });

  test("resetBoard test - row: 2, col: 0", () {
    target.state = target.state.placeMark(2, 0);
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['X', '', ''],
    ]);
    target.state = target.state.resetBoard();
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
  });

  test("resetBoard test - row: 2, col: 1", () {
    target.state = target.state.placeMark(2, 1);
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', 'X', ''],
    ]);
    target.state = target.state.resetBoard();
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
  });

  test("resetBoard test - row: 2, col: 2", () {
    target.state = target.state.placeMark(2, 2);
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', 'X'],
    ]);
    target.state = target.state.resetBoard();
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
  });
}
