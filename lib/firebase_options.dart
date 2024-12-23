// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAj7rI3vFLxdfefQJdwXZAr8_cpz91g9CE',
    appId: '1:953371926892:web:fb89167a1ccbcb73eb5349',
    messagingSenderId: '953371926892',
    projectId: 'dean-76ca1',
    authDomain: 'dean-76ca1.firebaseapp.com',
    storageBucket: 'dean-76ca1.firebasestorage.app',
    measurementId: 'G-RH0K3BK0RT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzmfQ_Z2NrZcLh8UwFmQwKVndcwdnWaPE',
    appId: '1:953371926892:android:c5088bfdbf007f47eb5349',
    messagingSenderId: '953371926892',
    projectId: 'dean-76ca1',
    storageBucket: 'dean-76ca1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbAnQEvfHsjVh8Rvkv7NJ_uhvvIPNHSx0',
    appId: '1:953371926892:ios:4b8bea99626fc923eb5349',
    messagingSenderId: '953371926892',
    projectId: 'dean-76ca1',
    storageBucket: 'dean-76ca1.firebasestorage.app',
    androidClientId: '953371926892-0rg2c8pf4hpkqiot29adkcffone0926b.apps.googleusercontent.com',
    iosClientId: '953371926892-716n73kh861dr1l2m5m150i67jvtcics.apps.googleusercontent.com',
    iosBundleId: 'com.example.deAn',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbAnQEvfHsjVh8Rvkv7NJ_uhvvIPNHSx0',
    appId: '1:953371926892:ios:4b8bea99626fc923eb5349',
    messagingSenderId: '953371926892',
    projectId: 'dean-76ca1',
    storageBucket: 'dean-76ca1.firebasestorage.app',
    androidClientId: '953371926892-0rg2c8pf4hpkqiot29adkcffone0926b.apps.googleusercontent.com',
    iosClientId: '953371926892-716n73kh861dr1l2m5m150i67jvtcics.apps.googleusercontent.com',
    iosBundleId: 'com.example.deAn',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAj7rI3vFLxdfefQJdwXZAr8_cpz91g9CE',
    appId: '1:953371926892:web:8a8d656faaa4cf98eb5349',
    messagingSenderId: '953371926892',
    projectId: 'dean-76ca1',
    authDomain: 'dean-76ca1.firebaseapp.com',
    storageBucket: 'dean-76ca1.firebasestorage.app',
    measurementId: 'G-FVDNJMD2ZS',
  );

}