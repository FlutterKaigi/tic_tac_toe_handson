class TicTacToe {
  final List<List<String>> board;
  final String currentPlayer;

  factory TicTacToe.start() {
    return TicTacToe._([
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ], 'X');
  }

  TicTacToe._(this.board, this.currentPlayer);

  TicTacToe placeMark(int row, int col) {
    if (board[row][col] == '') {
      final newBoard = board.map<List<String>>((row) => List.from(row)).toList();
      newBoard[row][col] = currentPlayer;
      String nextPlayer = currentPlayer == 'X' ? 'O' : 'X';

      return TicTacToe._(newBoard, nextPlayer);
    }
    return this;
  }

  String getWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] != '') {
        return board[i][0];
      }
      if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != '') {
        return board[0][i];
      }
    }
    if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != '') {
      return board[0][0];
    }
    if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != '') {
      return board[0][2];
    }
    return '';
  }

  bool isDraw() {
    return getWinner() == '' && board.every((row) => row.every((cell) => cell != ''));
  }

  TicTacToe resetBoard() {
    return TicTacToe.start();
  }
}
