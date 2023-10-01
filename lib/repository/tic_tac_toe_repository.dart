import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_handson/model/tic_tac_toe.dart';

final ticTacToeRepositoryProvider = AutoDisposeProvider<TicTacToeRepository>(
  (ref) => TicTacToeRepository(),
);

/// 盤面のデータを管理するリポジトリ
final class TicTacToeRepository {
  TicTacToeRepository();

  final _client = FirebaseFirestore.instance;
  static const _collectionKey = 'tic_tac_toe';

  String _documentKey(String playerX, String playerO) {
    return '${playerX}_$playerO';
  }

  CollectionReference<TicTacToe> _colRef() =>
      _client.collection(_collectionKey).withConverter(
            fromFirestore: (doc, _) => TicTacToe.fromJson(doc.data()!),
            toFirestore: (entity, _) => entity.toJson(),
          );

  /// 盤面のデータを取得する
  Stream<TicTacToe> get({
    String playerX = 'X',
    String playerO = 'O',
  }) {
    final documentKey = _documentKey(playerX, playerO);
    return _colRef().doc(documentKey).snapshots().map(
          (e) =>
              e.data() ??
              TicTacToe.start(
                playerX: playerX,
                playerO: playerO,
              ),
        );
  }

  /// 盤面のデータを更新する
  Future<void> update(TicTacToe ticTacToe) async {
    final documentKey =
        _documentKey(ticTacToe.players.playerX, ticTacToe.players.playerO);
    await _colRef().doc(documentKey).set(ticTacToe);
  }
}
