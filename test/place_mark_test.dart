import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tic_tac_toe_handson/provider/tic_tac_toe_provider.dart';

void main() {
  late TicTacToeProvider target;

  setUp(() {
    final container = ProviderContainer();
    target = container.read(ticTacToeProvider.notifier);
  });

  test("placeMark test - row: 0, col: 0", () {
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
    target.placeMark(0, 0);
    expect(target.state.board, [
      ['X', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
  });

  test("placeMark test - row: 0, col: 1", () {
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
    target.placeMark(0, 1);
    expect(target.state.board, [
      ['', 'X', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
  });

  test("placeMark test - row: 0, col: 2", () {
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
    target.placeMark(0, 2);
    expect(target.state.board, [
      ['', '', 'X'],
      ['', '', ''],
      ['', '', ''],
    ]);
  });

  test("placeMark test - row: 1, col: 0", () {
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
    target.placeMark(1, 0);
    expect(target.state.board, [
      ['', '', ''],
      ['X', '', ''],
      ['', '', ''],
    ]);
  });

  test("placeMark test - row: 1, col: 1", () {
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
    target.placeMark(1, 1);
    expect(target.state.board, [
      ['', '', ''],
      ['', 'X', ''],
      ['', '', ''],
    ]);
  });

  test("placeMark test - row: 1, col: 2", () {
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
    target.placeMark(1, 2);
    expect(target.state.board, [
      ['', '', ''],
      ['', '', 'X'],
      ['', '', ''],
    ]);
  });

  test("placeMark test - row: 2, col: 0", () {
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
    target.placeMark(2, 0);
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['X', '', ''],
    ]);
  });

  test("placeMark test - row: 2, col: 1", () {
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
    target.placeMark(2, 1);
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', 'X', ''],
    ]);
  });

  test("placeMark test - row: 2, col: 2", () {
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]);
    target.placeMark(2, 2);
    expect(target.state.board, [
      ['', '', ''],
      ['', '', ''],
      ['', '', 'X'],
    ]);
  });
}
