# Riverpod の導入

まずは`flutter_riverpod` をプロジェクトに追加します。

```sh
flutter pub add flutter_riverpod
```

## 4.1 Provider の作成

まず、盤面の状態を管理するためのProviderを作成します。

`lib`ディレクトリ配下に`provider`ディレクトリを、さらにその配下に`tic_tac_toe_provider.dart`を作成します。

```bash {4-5}
🗂 lib
   └ 🗂 model                          : 各種データモデル
      - 📄 tic_tac_toe.dart            : 三目並べのデータモデル
   └ 🗂 provider                       : 各種プロバイダー
      - 📄 tic_tac_toe_provider.dart   : 三目並べのプロバイダー
   └ 🗂 view                           : 各種ページビュー
      - 📄 board.dart                  : 三目並べのページビュー
   - 📄 main.dart                      : アプリケーションのエントリーファイル
- 📄 pubspec.yaml                      : アプリケーションで使う依存関係の設定
```

`tic_tac_toe_provider.dart`作成手順は下記の通り進めましょう。

1. プロジェクトの`lib`ディレクトリの中に、新しく`provider`というディレクトリを作成します。
2. その中に`tic_tac_toe_provider.dart`というファイルを作成します。
3. 以下のコードをファイルに書き込みます。

```dart
// lib/provider/tic_tac_toe_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_handson/model/tic_tac_toe.dart';

final ticTacToeProvider = StateProvider<TicTacToe>((ref) {
  return TicTacToe.start();
});
```

`StateProvider`を使うことでProviderで保持する盤面の状態を変更することができます。初期状態は`TicTacToe.start()`で設定しておきます。

ちなみに、Providerに`.autoDispose`修飾子をつけると、そのProviderがアプリケーションのどこからも使われなくなった際にRiverpod側で自動でデータを破棄してくれます。特に理由がない限りは`.autoDispose`をつけておくことをお勧めします。ちなみに、`AutoDisposeStateProvider`というProviderを使っても同様のことを実現できます。

```dart
StateProvider.autoDispose
```

## 4.2 状態変化に応じて UI を更新する

次にUIに関するコードを変更していきます。

### 4.2.1 `main.dart`の更新

Riverpodをアプリケーション内で利用するには、`ProviderScope`でラップする必要があります。
Widget内でProviderの値を読み取れるようにしておくためには、アプリケーション全体を`ProviderScope`でラップする必要があります。

```dart
// lib/main.dart
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```

### 4.2.2 `view/board.dart`の更新

Widget内で`provider`にアクセスするには`ConsumerWidget`を継承します。

`ConsumerWidget`では、`build`メソッドの第二引数に`WidgetRef ref`を追加されます。これを使ってProviderにアクセスすることができ、`ref.watch`でproviderで保持している状態の値を読み取ることができます。また、provider内の状態が変わるたびにConsumerWidgetが再描画されるようになります。

```dart
// lib/view/board.dart
class Board extends ConsumerWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticTacToe = ref.watch(ticTacToeProvider);

    // ...略...
  }
}
```

`ref`には`ref.watch`と`ref.read`の2種類の主な使い方があります。`ref.watch`はproviderの状態が変わるたびに再描画が走りますが、`ref.read`はその時の値を一度だけ読み取るだけです。

### 4.2.3 状態の更新方法

最後に状態の更新処理を変更していきます。`ref.read(ticTacToeProvider.notifier).state`でproviderの状態にアクセスし、それに対して値を代入することで状態を更新しています。

マークを配置する処理は以下のようになります。

```dart
return GestureDetector(
  onTap: () {
    final winner = ticTacToe.getWinner();
    if (mark.isEmpty && winner.isEmpty) {
      ref.read(ticTacToeProvider.notifier).state = ticTacToe.placeMark(row, col);
    }
  },
  // ...略...
)
```

また、ゲームのリセットは以下のようになります。

```dart
ElevatedButton(
  onPressed: () {
    ref.read(ticTacToeProvider.notifier).state = ticTacToe.resetBoard();
  },
  child: const Text('ゲームをリセット'),
)
```

これで状態の管理と盤面のUI更新をRiverpodを使って行うことができるようになりました。
