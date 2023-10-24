# アプリケーションの基本構造とゲームロジック

::: tip

この章では Riverpod を使え前に StatefulWidget を利用することを目指します。

:::

## 2.1: アプリケーション全体の構造

```bash
🗂 lib
   └ 🗂 model                          : 各種データモデル
      - 📄 tic_tac_toe.dart            : 三目並べのデータモデル
   └ 🗂 view                           : 各種ページビュー
      - 📄 board.dart                  : 三目並べのページビュー
   - 📄 main.dart                      : アプリケーションのエントリーファイル
- 📄 pubspec.yaml                      : アプリケーションで使う依存関係の設定
```

## 2.2: 三目並べの基本的なゲームロジックの実装

State クラス `_BoardState` と、そのインスタンスを呼び出すクラス `Board` を作成しましょう。

```dart [lib/view/board.dart] {3,7-9,12}
import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BoardState();
  }
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    //
  }
}
```

実際に、全て不変的なプロパティを持つ StatelessWidget の一方で、StatefulWidget では状態を持つことができます。

### 三目並べの初期設定

まず、三目並べで必要なプレーヤーのデータモデルを定義するため、Players クラスを作成します。

```dart [lib/model/tic_tac_toe.dart]
class Players {
  final String playerX;
  final String playerO;

  Players({
    required this.playerX,
    required this.playerO,
  });
}
```

作成した Players クラスを下に、プレーヤーを2体、準備します。

今回はオフィシャルなマスコットを拝借しましょう。

- Flutter側よりDashくん
- Firebase側よりSparkyくん

### 三目並べの勝利判定

三目並べの勝利条件を判定します。

```dart [lib/view/board.dart]
import 'package:tic_tac_toe_handson/provider/tic_tac_toe_provider.dart';

TicTacToe ticTacToe = TicTacToe.start(playerX: 'Dash', playerO: 'Sparky');

final row = index ~/ 3;
final col = index % 3;
final mark = ticTacToe.board[row][col];

final winner = ticTacToe.getWinner();

if (mark.isEmpty && winner.isEmpty) {
  ticTacToe = ticTacToe.placeMark(row, col);
}
```

### 三目並べのリセット

三目並べの進行状況をリセットします。

```dart [lib/provider/tic_tac_toe_provider.dart]
import 'package:tic_tac_toe_handson/provider/tic_tac_toe_provider.dart';

TicTacToe ticTacToe = TicTacToe.start(playerX: 'Dash', playerO: 'Sparky');

ticTacToe = ticTacToe.resetBoard();
```

## コントリビューター

<BaseProfile avatar-url="/staff/yuma-kitamura.png" name="jiyuujin" title="少し前に副業で Flutter + Provider を使ったアプリ開発で経験させてもらいつつ、一昨年・昨年は FlutterKaigi ウェブサイトのコントビュート・リードもさせていただいておりました。" twitter-url="https://twitter.com/jiyuujinlab" />
