## Riverpodとは
RiverpodはDart/Flutterで使用できる状態管理ライブラリです。
[Remi Rousselet](https://github.com/rrousselGit) 氏によって作成されており、Riverpodの他に「freezed」「flutter_hooks」なども作成されております。
「Provider」についても同氏が作成している状態管理ライブラリですが、公式FAQにおいても「多分、Providerは非推奨にする予定で、Riverpodへの移行ツールも計画している」とのことで、作者自身もRiverpodの使用を推奨しております。
ちなみにRiverpodはProviderのアナグラムです。

## Riverpodのメリット
Flutterの状態管理手法はStatefulWidgetPatternをはじめ、様々あります。
その中でRiverpodを使用するメリットは以下が挙げられると考えております。

- 複数のWidgetから状態にアクセスができる
- keepAliveやautoDisposeにより、安全に破棄ができる
- Consumer等を適切に使用することでパーフォマンスの向上（Widgetの再構築）に繋がる/selectによるスコープの絞り込みもできる
- 複数のProvider（状態）を噛み合わせることができる
- riverpod_generatorと併用することでclassやmethodの記法でProvderを作成できる
- DIもしやすく、テストの容易性の向上に繋がる（Override）
- Flutter Favoriteである

## Riverpodの使い方
以下は公式ドキュメントのサンプルからriverpod_generatorを使用しない形式に修正したものです。

``` dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// String の状態を取り扱いたい場合、以下のように記載します。
final helloWorldProvider = StateProvider<String>((ref) => 'Hello world');

// main.dartのrunAppの部分でProviderScopeを入れ込みます。
// ProviderScopeで囲うことによりアクセスが可能となります。
void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// providerを使用するWidgetでは基本的にStatelessWidgetの代わりにConsumerWidgetを使用します。
// 利用したいproviderをref.watchで参照することで状態を取り扱うことが可能です。
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Text(value),
        ),
      ),
    );
  }
}

```
