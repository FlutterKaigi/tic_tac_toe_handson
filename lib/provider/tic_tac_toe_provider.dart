import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_handson/model/tic_tac_toe.dart';

final ticTacToeProvider = StateNotifierProvider.autoDispose<TicTacToeProvider, TicTacToe>((ref) {
  return TicTacToeProvider();
});

class TicTacToeProvider extends StateNotifier<TicTacToe> {
  TicTacToeProvider() : super(TicTacToe.start());

  placeMark(int row, int col) {
    state = state.placeMark(row, col);
  }

  resetBoard() {
    state = state.resetBoard();
  }
}
