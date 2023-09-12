import 'package:freezed_annotation/freezed_annotation.dart';

part 'tic_tac_toe.freezed.dart';

@freezed
class TicTacToe with _$TicTacToe {
  const TicTacToe._();

  const factory TicTacToe({
    required final List<List<String>> board,
    required final String currentPlayer,
  }) = _TicTacToe;

  factory TicTacToe.start() {
    return const TicTacToe(board: [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ], currentPlayer: 'X');
  }

  TicTacToe placeMark(int row, int col) {
    if (board[row][col].isEmpty) {
      final newBoard = List.of(board);
      newBoard[row][col] = currentPlayer;
      String nextPlayer = currentPlayer == 'X' ? 'O' : 'X';

      return TicTacToe(board: newBoard, currentPlayer: nextPlayer);
    }
    return this;
  }

  String getWinner() {
    for (int i = 0; i < 3; i++) {
      // row = i における横の判定
      if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0].isNotEmpty) {
        return board[i][0];
      }
      // col = i における縦の判定
      if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i].isNotEmpty) {
        return board[0][i];
      }
    }
    // 左上から右下への斜めの判定
    if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0].isNotEmpty) {
      return board[0][0];
    }
    // 右上から左下への斜めの判定
    if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2].isNotEmpty) {
      return board[0][2];
    }
    return '';
  }

  bool isDraw() {
    return getWinner().isEmpty && board.every((row) => row.every((cell) => cell.isNotEmpty));
  }

  TicTacToe resetBoard() {
    return TicTacToe.start();
  }
}
