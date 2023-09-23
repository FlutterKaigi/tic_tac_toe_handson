import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tic_tac_toe_handson/model/tic_tac_toe.dart';

final client = FirebaseFirestore.instance;
const rootCollectionKey = 'tic_tac_toe';

Stream<TicTacToe> getTicTacToe({String playerX = 'X', String playerO = 'O'}) {
  final documentKey = _documentKey(playerX, playerO);
  return client.collection(rootCollectionKey).doc(documentKey).snapshots().map((snapshot) {
    final data = snapshot.data();
    if (data == null) {
      return TicTacToe.start(playerX: playerX, playerO: playerO);
    }

    return TicTacToe.fromJson(data);
  });
}

Future<void> updateTicTacToe(TicTacToe ticTacToe) async {
  final documentKey = _documentKey(ticTacToe.players.playerX, ticTacToe.players.playerO);
  await client.collection(rootCollectionKey).doc(documentKey).set(ticTacToe.toJson());
}

String _documentKey(String playerX, String playerO) {
  return '${playerX}_${playerO}';
}
