# 2. アプリケーションの基本構造とゲームロジック

::: tip

この章では Riverpod を使う前に必要となるゲームロジックの実装を目指します。

:::

## 2.1: アプリケーション全体の構造

第4章まで進めた場合、プロジェクトの構成は以下のようになる予定です。この章では、`model`ディレクトリに当たる部分の実装を行なっていきます。

```bash
🗂 lib
   └ 🗂 model                          : 各種データモデル
      - 📄 tic_tac_toe.dart            : 三目並べのデータモデル
      - 📄 players.dart                : プレイヤーのデータモデル
   └ 🗂 provider                       : 各種Provider
      - 📄 tic_tac_toe_provider.dart   : 三目並べの状態管理用のProvider
   └ 🗂 view                           : 各種ページビュー
      - 📄 board.dart                  : 三目並べのページビュー
   - 📄 main.dart                      : アプリケーションのエントリーファイル
- 📄 pubspec.yaml                      : アプリケーションで使う依存関係の設定
```

## 2.2: 三目並べの基本的なゲームロジックの実装

### 2.2.1: 必要なものの整理

まず、三目並べに必要なものを整理しましょう。

今回の三目並べでは以下のデータが必要になってきます。

- プレイヤーのデータ
  - 誰がXで、誰がOのマークなのか
- 盤面のデータ
  - 現在のプレイヤーはXとOのどちらなのか
  - 盤面のどこにどんなマークが置かれているか

次に、三目並べで遊ぶためには以下の操作や判定が必要になってきます。

- ゲームの開始
- マークの配置
- 勝者は誰か
  - 縦・横・斜めで同じマークが並んだとき、そのマークに当たるプレイヤーが勝者です
- 引き分けかどうか
  - 勝者が存在せず、盤面が全てマークで埋まっているとき引き分けになります
- ゲームのリセット

これらに当たるクラスとメソッドを`model`ディレクトリ内に実装していきましょう。

### 2.2.1: Playersの実装

まず、三目並べで必要なプレーヤーのデータモデルを定義するため、`Players` クラスを作成します。

```dart
// lib/model/players.dart

class Players {
  final String playerX;
  final String playerO;

  Players({
    required this.playerX,
    required this.playerO,
  });
}
```

### 2.2.2: TicTacToeの実装

次に、盤面のデータモデルとして`TicTacToe`クラスを作成します。このクラスの中に、三目並べで必要になる操作や判定をするためのメソッドを定義していきます。

```dart
// lib/model/tic_tac_toe.dart

import 'package:tic_tac_toe_handson/model/players.dart';

class TicTacToe {
  // 盤面のデータを二次元配列として表現する
  final List<List<String>> board;
  final Players players;
  final String currentPlayer;

  TicTacToe(this.board, this.players, this.currentPlayer);
}
```

まずはゲームの開始するためのメソッドです。

```dart
factory TicTacToe.start({
  playerX = 'X',
  playerO = 'O',
}) {
  final players = Players(
    playerX: playerX,
    playerO: playerO,
  );

  return TicTacToe(
    [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ],
    players,
    players.playerX,
  );
}
```

マス目にマークを配置するメソッドです。マス目が空欄である場合、現在のプレイヤーのマークを配置して現在のプレイヤーを更新します。

```dart
TicTacToe placeMark(int row, int col) {
  if (board[row][col].isEmpty) {
    final newBoard = List.of(board);
    newBoard[row][col] = currentPlayer == players.playerX ? 'X' : 'O';
    String nextPlayer = currentPlayer == players.playerX ? players.playerO : players.playerX;

    return TicTacToe(newBoard, players, nextPlayer);
  }
  return this;
}
```

勝者を判定するためのメソッドです。長いですが、内容としては盤面の縦・横・斜めに同じマークが連続しているかを判定し、そうであれば該当のプレイヤーを返しているのみです。

```dart
String getWinner() {
  for (int i = 0; i < 3; i++) {
    // row = i における横の判定
    if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0].isNotEmpty) {
      return board[i][0] == 'X' ? players.playerX : players.playerO;
    }
    // col = i における縦の判定
    if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i].isNotEmpty) {
      return board[0][i] == 'X' ? players.playerX : players.playerO;
    }
  }
  // 左上から右下への斜めの判定
  if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0].isNotEmpty) {
    return board[0][0] == 'X' ? players.playerX : players.playerO;
  }
  // 右上から左下への斜めの判定
  if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2].isNotEmpty) {
    return board[0][2] == 'X' ? players.playerX : players.playerO;
  }
  return '';
}
```

引き分けかどうかを判定するメソッドです。勝者が存在せず、盤面が全てマークで埋まっているとき引き分けになります。

```dart
bool isDraw() {
  return getWinner().isEmpty && board.every((row) => row.every((cell) => cell.isNotEmpty));
}
```

ゲームをリセットするメソッドです。`start`を呼び出し、現在のプレイヤーのまま盤面の状態を初期化します。

```dart
TicTacToe resetBoard() {
  return TicTacToe.start(playerX: players.playerX, playerO: players.playerO);
}
```

以上が第4章までに必要となるクラスとメソッドの実装になります。

## コントリビューター

<BaseProfile avatar-url="/staff/yuma-kitamura.png" name="jiyuujin" title="少し前に副業で Flutter + Provider を使ったアプリ開発で経験させてもらいつつ、一昨年・昨年は FlutterKaigi ウェブサイトのコントビュート・リードもさせていただいておりました。" twitter-url="https://twitter.com/jiyuujinlab" />
