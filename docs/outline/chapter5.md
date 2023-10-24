## Firestoreに繋ぐ準備をする

プロジェクトルートで以下のコマンドを実行し、必要なライブラリを取得しましょう。

```zsh
flutter pub add firebase_core
flutter pub add cloud_firestore
```

`firebase_options.dart` をLibに追加します。

```dart
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCWnRieFsedimIvgsjNevAdUSb0dm1faY',
    appId: '1:807943088200:android:d989c8a1b020562321907d',
    messagingSenderId: '807943088200',
    projectId: 'tic-tac-toe-handson',
    storageBucket: 'tic-tac-toe-handson.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZHELrAr4SRfXLYrxc4zF27P0R3sGsbi0',
    appId: '1:807943088200:ios:125d7bfaa751582d21907d',
    messagingSenderId: '807943088200',
    projectId: 'tic-tac-toe-handson',
    storageBucket: 'tic-tac-toe-handson.appspot.com',
    iosBundleId: 'com.example.ticTacToeHandson',
  );
}
```

次に `main.dart` を修正します。

```dart
// importを追加
import 'package:firebase_core/firebase_core.dart';
import 'package:tic_tac_toe_handson/firebase_options.dart';

// asyncに修正
void main() async {
  // 追加
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 略
}
```

### 1. Androidでのビルド準備を進める

`android/build.gradle` に以下を追記します。

```txt
classpath 'com.google.gms:google-services:4.3.10'
```

`android/app/build.gradle` に以下を追記します。

```txt
apply plugin: 'com.google.gms.google-services'
```

また`defaultConfig`の中に記載がない場合、以下も追記します。

```txt
multiDexEnabled true
```

[GitHub Discussions](https://github.com/FlutterKaigi/tic_tac_toe_handson/discussions) から `google-services.json` を取得し、`android/app`に追加します。

### 2. iOSでのビルド準備を進める

iOSフォルダをXcodeで開いたのちに、Runnerに[GitHub Discussions](https://github.com/FlutterKaigi/tic_tac_toe_handson/discussions) で取得した `GoogleService-Info.plist` を追加します。  
このとき、「Copy items if needed」にチェックを入れて追加してください。

![Alt text](../public/chapter5/add_plist.png)

これで基本的な準備は完了！  
ハンズオン用に手動でしましたが、[FlutterFire](https://firebase.flutter.dev/)を使用することでコマンドで簡単にできます。

## modelにjsonコンバートメソッドを追加する

`lib/model/tic_tac_toe.json` の`TicTacToe`クラス内に以下を追加します。  
[freezed](https://pub.dev/packages/freezed) を使用することで、jsonコンバートはコマンド１発で作成可能ですが、ここでは自作してみましょう。

```dart
  factory TicTacToe.fromJson(Map<String, dynamic> json) {
    final flatBoard = List<String>.from(json['board']);

    return TicTacToe(
      // Firestore側を1次元配列にしているので、モデルの2次元配列とここで合わせる
      [
        List<String>.from(flatBoard.sublist(0, 3)),
        List<String>.from(flatBoard.sublist(3, 6)),
        List<String>.from(flatBoard.sublist(6, 9)),
      ],
      Players(
        playerX: json['players']['playerX'],
        playerO: json['players']['playerO'],
      ),
      json['currentPlayer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // モデルが2次元配列なので、Firestore側の1次元配列にここで合わせる
      'board': [...board[0], ...board[1], ...board[2]],
      'players': {
        'playerX': players.playerX,
        'playerO': players.playerO,
      },
      'currentPlayer': currentPlayer,
    };
  }
```

## リポジトリを作成する

まずは、新しいファイルを作りましょう。
`lib/repository/tic_tac_toe_repository.dart`

続いて、クラスを作成します。

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tic_tac_toe_handson/model/tic_tac_toe.dart';

/// 盤面のデータを管理するリポジトリ
final class TicTacToeRepository {
  TicTacToeRepository();
  // Firestoreインスタンス
  final _client = FirebaseFirestore.instance;
  // Firestoreのコレクション先
  static const _collectionKey = 'tic_tac_toe';
  // 対戦状況を保存するドキュメント先
  String _documentKey(String playerX, String playerO) {
    return '${playerX}_$playerO';
  }
  // jsonコンバート
  CollectionReference<TicTacToe> _colRef() =>
      _client.collection(_collectionKey).withConverter(
            fromFirestore: (doc, _) => TicTacToe.fromJson(doc.data()!),
            toFirestore: (entity, _) => entity.toJson(),
          );
}
```

### 1. getメソッドを追加する

リポジトリのクラスにFirestoreからデータを取得するメソッドを記載しましょう。

```dart
  /// 盤面のデータを取得する
  Stream<TicTacToe> get({
    String playerX = 'X',
    String playerO = 'O',
  }) {
    // ドキュメント名に変換する
    final documentKey = _documentKey(playerX, playerO);
    // スナップショットを取得し、モデルへ変換する
    // データがない場合、モデルの初期状態を返す
    return _colRef().doc(documentKey).snapshots().map(
          (e) =>
              e.data() ??
              TicTacToe.start(
                playerX: playerX,
                playerO: playerO,
              ),
        );
  }
```

### 2. updateメソッドを追加する

リポジトリのクラスにFirestoreへデータを保存するメソッドを記載しましょう。

```dart
  /// 盤面のデータを更新する
  Future<void> update(TicTacToe ticTacToe) async {
    // ドキュメント名に変換する
    final documentKey =
        _documentKey(ticTacToe.players.playerX, ticTacToe.players.playerO);
    // モデルをjsonに変換し、firestoreへ保存する
    await _colRef().doc(documentKey).set(ticTacToe);
  }
```

### 3. リポジトリをProvider化する

リポジトリのファイルに以下を追加します。  
この後、getとupdateをそれぞれProvider化する際に使用します。

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ticTacToeRepositoryProvider = AutoDisposeProvider<TicTacToeRepository>(
  (ref) => TicTacToeRepository(),
);
```

## データを取得するProviderを作成する

新しいファイルを作りましょう。  
`lib/provider/get_tic_tac_toe_provider.dart`

以下を記載してください。

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_handson/model/tic_tac_toe.dart';
import 'package:tic_tac_toe_handson/repository/tic_tac_toe_repository.dart';

final getTicTacToeProvider = AutoDisposeStreamProvider<TicTacToe>(
  (ref) =>
      // 対戦相手同士のIDを設定する（プレイヤー名は後ほど変更します）
      ref.watch(ticTacToeRepositoryProvider).get(
            playerX: 'Dash',
            playerO: 'Sparky',
          ),
);

```

`ticTacToeRepositoryProvider` を使用しています。  
RiverpodではこのようにProviderの中で別のProviderを組み合わせることが可能です。

FirestoreはWebSocketが基盤になっているため、リアルタイムでデータを送受信することが可能です。  
その利点を活かして、今回は`Stream`でデータを取得するようにします。

## データを保存するProviderを作成する

新しいファイルを作りましょう。  
`lib/provider/update_tic_tac_toe_provider.dart`

以下を記載してください。

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_handson/model/tic_tac_toe.dart';
import 'package:tic_tac_toe_handson/repository/tic_tac_toe_repository.dart';

final updateTicTacToeProvider =
    AutoDisposeFutureProviderFamily<void, TicTacToe>(
  (ref, arg) => ref.watch(ticTacToeRepositoryProvider).update(arg),
);
```

引数を与えて、何かを実施したい場合、`Family` を付与することで実現できます。  
今回は盤面の情報を引数にして渡したいので、使用しています。

ここでも `ticTacToeRepositoryProvider` を使用しています。  
`ticTacToeRepositoryProvider` を使用することでget用のProviderと同一の `TicTacToeRepository` クラスのインスタンスを参照することができます。

余談ですが、今回の場合は `AsyncNotifier` を使用することもできます。  
色々な種類のProviderを使用したいという思いがあり、ハンズオンではこの形式にしました。

## 作成したProviderをWidgetで使用する

getとupdateをそれぞれProviderにしたため、そちらをWidgetで使用しましょう。
`lib/view/board.dart` を修正します。

まずは参照の追加です。

```dart
import 'package:tic_tac_toe_handson/provider/get_tic_tac_toe_provider.dart';
import 'package:tic_tac_toe_handson/provider/update_tic_tac_toe_provider.dart';
```

次に使用するProviderを変更しましょう。

```dart
    // final ticTacToe = ref.watch(ticTacToeProvider);
    final ticTacToeStream = ref.watch(getTicTacToeProvider);
```

今、returnしているPaddingを以下のコードで囲みます。

```dart
    return ticTacToeStream.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, __) => Center(child: Text('エラーが発生しました: ${error.toString()}')),
      data: (ticTacToe) {
        return Padding(
        // 略
        );
      },
    );
```

Riverpodを使用すると `AsyncValue` を返却するProviderでは、このように `when` を使用することが可能です。

`loading` はデータがローディングの際に実施したい処理とWidgetを記載します。  
`error` はデータがエラーの際に実施したい処理とWidgetを記載します。  
`data` はデータが取得できた際に実施したい処理とWidgetを記載します。

このように非同期処理の内容をWidgetで簡単に取り扱うことが可能です。

では、最後にupdate用のProviderもそれぞれ変更しましょう。

```dart
// ref.read(ticTacToeProvider.notifier).state = ticTacToe.placeMark(row, col);
ref.read(updateTicTacToeProvider(ticTacToe.placeMark(row, col)),);
```

```dart
// ref.read(ticTacToeProvider.notifier).state = ticTacToe.resetBoard();
ref.read(updateTicTacToeProvider(ticTacToe.resetBoard()),);
```

これで準備は完了です！

## リアルタイムでデームをプレイする

[GithubDiscussions](https://github.com/FlutterKaigi/tic_tac_toe_handson/discussions) に対戦相手募集中のスレッドを用意しております。

対戦を待つ場合は、そちらに自身のプレイヤー名を記載してください。  
対戦を申し込む場合は、返信形式でプレイヤー名を記載してください。

対戦相手が決まったら、`get_tic_tac_toe_provider.dart` を以下のように修正してください。

```dart
final getTicTacToeProvider = AutoDisposeStreamProvider<TicTacToe>(
  (ref) =>
      ref.watch(ticTacToeRepositoryProvider).get(
            playerX: '申し込まれたプレイヤー名',
            playerO: '申し込んだプレイヤー名',
          ),
);
```

それでは遊んでみてください。

iOSでビルドした際に、Podfileに以下のコマンドが記載されている場合、コメントアウトすることで実行できます。

```txt
#   target 'RunnerTests' do
#     inherit! :search_paths
#   end
```

## コントリビューター

<BaseProfile avatar-url="/staff/daichi-aoki.png" name="ちっぴー" title="FlutterとFirebaseをよく扱っており、Riverpodは重宝しております！ハンズオンを通して学びを一緒に深めていきましょう👾" twitter-url="https://twitter.com/chippy_ao" />
