import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_handson/model/tic_tac_toe.dart';
import 'package:tic_tac_toe_handson/repository/tic_tac_toe_repository.dart';

final updateTicTacToeProvider =
    AutoDisposeFutureProviderFamily<void, TicTacToe>(
  (ref, arg) => ref.watch(ticTacToeRepositoryProvider).update(arg),
);
