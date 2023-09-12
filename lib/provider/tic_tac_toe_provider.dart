import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe_handson/model/tic_tac_toe.dart';

part 'tic_tac_toe_provider.g.dart';

@riverpod
class TicTacToeBoard extends _$TicTacToeBoard {
  @override
  TicTacToe build() => TicTacToe.start();

  placeMark(int row, int col) {
    state = state.placeMark(row, col);
  }

  resetBoard() {
    state = state.resetBoard();
  }
}
