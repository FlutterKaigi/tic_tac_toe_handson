import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_handson/model/tic_tac_toe.dart';

final ticTacToeProvider = StateProvider.autoDispose<TicTacToe>((ref) {
  return TicTacToe.start();
});
