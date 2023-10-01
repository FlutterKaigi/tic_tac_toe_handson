import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_handson/model/tic_tac_toe.dart';
import 'package:tic_tac_toe_handson/repository/tic_tac_toe_repository.dart';

final getTicTacToeProvider = AutoDisposeStreamProvider<TicTacToe>(
  (ref) =>
      // 対戦相手同士のIDを設定する
      ref.watch(ticTacToeRepositoryProvider).get(
            playerX: 'flutter',
            playerO: 'kaigi',
          ),
);
