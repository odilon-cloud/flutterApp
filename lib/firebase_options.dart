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
    apiKey: 'AIzaSyBYh1RMMkmTapafDN_mARhDkbZxVbc0dFw',
    appId: '1:713062652159:web:ee699fb50fa2e2686dd4ca',
    messagingSenderId: '713062652159',
    projectId: 'quiz12-ab599',
    authDomain: 'quiz12-ab599.firebaseapp.com',
    storageBucket: 'quiz12-ab599.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3FfCFk8gqSeMGdydt5nPMA-0ynwEpSHY',
    appId: '1:713062652159:android:bd0e490e0fe4a9516dd4ca',
    messagingSenderId: '713062652159',
    projectId: 'quiz12-ab599',
    storageBucket: 'quiz12-ab599.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCD4Ot33w0LmKspZdhPaSjlrS4JsPUq3ZU',
    appId: '1:713062652159:ios:900969dd452929236dd4ca',
    messagingSenderId: '713062652159',
    projectId: 'quiz12-ab599',
    storageBucket: 'quiz12-ab599.appspot.com',
    androidClientId: '713062652159-4nk04h1a89sc72gcau7thuss0i4t2jal.apps.googleusercontent.com',
    iosClientId: '713062652159-0hsl5cpkgs0v90g9ba45tlg9etv9sgvj.apps.googleusercontent.com',
    iosBundleId: 'com.example.midQuizMinapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCD4Ot33w0LmKspZdhPaSjlrS4JsPUq3ZU',
    appId: '1:713062652159:ios:2a482a2fae6b5b306dd4ca',
    messagingSenderId: '713062652159',
    projectId: 'quiz12-ab599',
    storageBucket: 'quiz12-ab599.appspot.com',
    androidClientId: '713062652159-4nk04h1a89sc72gcau7thuss0i4t2jal.apps.googleusercontent.com',
    iosClientId: '713062652159-cupoc5i3qhsaa5ujkumnbrj9qlibma9h.apps.googleusercontent.com',
    iosBundleId: 'com.example.midQuizMinapp.RunnerTests',
  );
}
