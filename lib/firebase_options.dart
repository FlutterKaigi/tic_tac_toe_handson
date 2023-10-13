// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAoY0U1veRmqWWMmFBULkerX6X5HYjMmIs',
    appId: '1:807943088200:web:eda1735cfd79d15e21907d',
    messagingSenderId: '807943088200',
    projectId: 'tic-tac-toe-handson',
    authDomain: 'tic-tac-toe-handson.firebaseapp.com',
    storageBucket: 'tic-tac-toe-handson.appspot.com',
  );

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

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZHELrAr4SRfXLYrxc4zF27P0R3sGsbi0',
    appId: '1:807943088200:ios:125d7bfaa751582d21907d',
    messagingSenderId: '807943088200',
    projectId: 'tic-tac-toe-handson',
    storageBucket: 'tic-tac-toe-handson.appspot.com',
    iosBundleId: 'com.example.ticTacToeHandson',
  );
}