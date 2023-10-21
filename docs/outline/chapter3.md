# UI の作成

## 3.1: UI の作成概要

### 3.1.1: 作成する UI について（三目並べのゲーム画面）

3章では、三目並べを遊ぶためのゲーム画面を作ります。  
作成するゲーム画面では、プレーヤーがタップすることで、指手の ○×マークを配置したり、
プレーヤーに次の指し手を促したり、ゲームの勝敗を告げたりすることができるようにします。

これらを前章で作成した「**ゲーム進行の状態を表す ゲームロジックのモデル**」を使って、  
ゲーム開始から終了までを **モデル内容の変遷 ⇒ 状態遷移** により表現できるようにします。

<ul>
  UI完成図<br/>
  <img src="../images/chapter3/chapter_3_1_1.png" alt="完成図" style="max-width:40%;">
  <!--
  ![完成図](../images/chapter3/chapter_3_1_1.png)
  -->
</ul>

- 脚注
  - **ゲームロジックのモデル**  
    [`TicTacTow クラス`](https://github.com/FlutterKaigi/tic_tac_toe_handson/blob/release/chapter3/lib/model/tic_tac_toe.dart)のインスタンス・オブジェクトを表します。  
    <br/>
  - **指手 / 指し手**  
    盤面に自分の戦略手（○×マーク）を打つこと。  
    もしくは、盤面に自分の戦略手（○×マーク）を置く人（プレーヤー）のこと。  
    <br/>


### 3.1.2: ゲームロジック モデル（ゲーム進行状態モデル）についてのおさらい。

1. **[TicTacTow クラス](https://github.com/FlutterKaigi/tic_tac_toe_handson/blob/release/chapter3/lib/model/tic_tac_toe.dart)**  
TicTacToe クラスは、三目並べゲームロジックのモデルです。  
そのインスタンス・オブジェクトは、三目並べゲームの「**盤面状態値**」と「**今回のプレーヤー値**」および「**盤面更新**」「**勝敗判定**」の機能を持っています。  
つまり「**次のゲームプレイ状態を提供**」できるようにする「**ある時点のゲーム進行状態**」を表すことができます。  
　  
_「**ゲームプレイの初期状態**」や、指し手により盤面更新された「**次のゲームプレイ状態**」および、
ゲーム再開のための「**新しいゲームプレイの初期状態**」を提供することに留意ください。  
これはゲームプレイ状態を保持して状態遷移を管理するコントローラではないことを表します。_  
<br/>

2. **[Players クラス](https://github.com/FlutterKaigi/tic_tac_toe_handson/blob/release/chapter3/lib/model/players.dart)**  
   プレーヤーを表す「**先手** ×マーク」と「**後手** ○マーク」のプレーヤー名を保持するモデルです。  
   <br/>

**【参考】TicTacToe クラスのプロパティおよびメソッドの概要一覧**
```dart
/// TicTacToe クラスのプロパティおよびメソッドの概要一覧
class TicTacToe {
  /// 三目並べゲームの盤面状態値（行:列からなる ○×マークを配置する2次元配列）
  final List<List<String>> board;

  /// 今回のプレーヤー値（今回の指手名）
  final String currentPlayer;

  /// 勝敗判定（勝者プレーヤー名、もしくは未決着なら空文字列が返る）
  String getWinner();

  /// （勝敗判定）引分終了判定（未決着でゲーム終了なら true が返る）
  bool isDraw();

  /// 盤面更新 ファクトリパターン・メソッド（今回の指し手により更新された、次のゲーム進行状態を返す）
  TicTacToe placeMark(int row, int col);

  /// 新しいゲームプレイの初期状態 ファクトリパターン・メソッド
  TicTacToe resetBoard();

  /// ゲームプレイの初期状態 ファクトリ
  factory TicTacToe.start()
}
```


### 3.2: UI 作成手順概要 （ゲーム画面の作成ステップ）

前章までの作業は、flutter プロジェクトの新規作成とゲームロジックのモデルの新規追加までとなっています。  
このためアプリの UIは、カウンターアプリのままですから、以下の手順で、三目並べを遊ぶための画面を作り上げていきます。

1. main パッケージの修正  
   前章でのアプリの UIは、カウンターアプリのままです。  
   このためプロジェクトにゲーム画面（`Board` ⇒ はじめは空コンテンツ）を新規追加します。  
   次に元々のカウンターアプリから不要コードの削除とアプリタイトルの修正を行い、  
   ホーム画面を `MyHomePage` からゲーム画面（はじめは空コンテンツ）に差し替えます。  
   <br/>
   <ul>
     <a href="https://github.com/FlutterKaigi/tic_tac_toe_handson/blob/release/chapter2/lib/main.dart">修正前 main パッケージ</a><br/>
     <img src="../images/chapter3/chapter_3_2_0.png" alt="修正前 main パッケージ" style="max-width:40%;">
     <!--
     ![修正前 main パッケージ](../images/chapter3/chapter_3_2_0.png)
     -->
     <br/>
     <br/>
   </ul>
   <ul>
     main パッケージの修正<br/>
     <img src="../images/chapter3/chapter_3_2_1.png" alt="main パッケージの修正" style="max-width:40%;">
     <!--
     ![main パッケージの修正](../images/chapter3/chapter_3_3_1.png)
     -->
     <br/>
     <br/>
   </ul>

2. 三目並べ盤面の追加  
   ゲーム画面（`Board`）に「ゲーム進行状態」から、**今までの指手（○×マーク）** の配置や、
   **今回のプレーヤーの指手（○×マーク）** を配置して、次の**ゲーム進行状態**に **状態遷移** できるようにします。  
   このために縦横 3x3 に区切られたマス目（セル）を新規追加します。  
   <br/>
   <ul>
     三目並べ盤面の追加<br/>
     <img src="../images/chapter3/chapter_3_2_2.png" alt="三目並べ盤面の追加" style="max-width:40%;">
     <!--
     ![三目並べ盤面の追加](../images/chapter3/chapter_3_2_2.png)
     -->
     <br/>
     <br/>
   </ul>

3. メッセージ表示欄の追加  
   ゲーム画面に「ゲーム進行状態」から **今回の指手や、ゲーム勝敗終了** を表示する、  
   メッセージ欄を新規追加します。  
   <br/>
   <ul>
     メッセージ表示欄の追加<br/>
     <img src="../images/chapter3/chapter_3_2_3.png" alt="メッセージ表示欄の追加" style="max-width:40%;">
     <!--
     ![メッセージ表示欄の追加](../images/chapter3/chapter_3_2_3.png)
     -->
     <br/>
     <br/>
   </ul>

4. ゲーム・リセットボタンの追加  
   ゲーム画面に、新しいゲーム（ゲームプレイの初期状態）へ **状態遷移** させる  
   リセット・ボタンを追加します。  
   <br/>
   <ul>
     ゲーム・リセットボタンの追加<br/>
     <img src="../images/chapter3/chapter_3_2_4.png" alt="ゲーム・リセットボタンの追加" style="max-width:40%;">
     <!--
     ![ゲーム・リセットボタンの追加](../images/chapter3/chapter_3_2_4.png)
     -->
     <br/>
     <br/>
   </ul>


### 3.3: UI 作成作業 （ゲーム画面の具体的作成ステップ）

三目並べを遊ぶための画面 UIの作成ステップを紹介しましたので、具体的な作業に入りましょう。

#### 3.3.1: main パッケージの修正
前章でのアプリの UIは、カウンターアプリのままです。  
このためプロジェクトにゲーム画面（`Board` ⇒ はじめは空コンテンツ）を新規追加します。  
次に元々のカウンターアプリから不要コードの削除とアプリタイトルの修正を行い、  
ホーム画面を `MyHomePage` からゲーム画面（はじめは空コンテンツ）に差し替えます。  


#### 3.3.2: 三目並べ盤面の追加
ゲーム画面（`Board`）に「ゲーム進行状態」から、**今までの指手（○×マーク）** の配置や、
**今回のプレーヤーの指手（○×マーク）** を配置して、次の**ゲーム進行状態**に **状態遷移** できるようにします。  
このために縦横 3x3 に区切られたマス目（セル）を新規追加します。  


#### 3.3.3: メッセージ表示欄の追加
ゲーム画面に「ゲーム進行状態」から **今回の指手や、ゲーム勝敗終了** を表示する、  
メッセージ欄を新規追加します。  


#### 3.3.4: ゲーム・リセットボタンの追加
ゲーム画面に、新しいゲーム（ゲームプレイの初期状態）へ **状態遷移** させる  
リセット・ボタンを追加します。  


#### 3.3.5: 三目並べのゲーム画面完成（ゲーム盤UI 作成作業完了）
[**完成した main パッケージのコード**](https://github.com/FlutterKaigi/tic_tac_toe_handson/blob/release/chapter3/lib/main.dart)

[**完成したゲーム画面(Board)のコード**](https://github.com/FlutterKaigi/tic_tac_toe_handson/blob/release/chapter3/lib/view/borad.dart)


### 3.4: ゲーム画面についての説明 （ゲーム盤UI 構成説明）



## コントリビューター

<BaseProfile avatar-url="/images/staff/rie-kanetaka.png" name="robo" title="既存 iOS/Android ネイティブアプリの Flutter リプレースに携わっております。Flutter の威力を見てください。" twitter-url="https://twitter.com/cch_robo" />

### メモ
* もう少し細かく区切った方が良さそう
