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
    apiKey: 'AIzaSyBF2398IdWbUNYPP0sDMokm9uEgvNXzT8U',
    appId: '1:945355309896:web:9d3954f221b23efa39697d',
    messagingSenderId: '945355309896',
    projectId: 'chat-app-4157b',
    authDomain: 'chat-app-4157b.firebaseapp.com',
    storageBucket: 'chat-app-4157b.appspot.com',
    measurementId: 'G-KGNFPGX7N0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZnKrV7CD2VMUKoGh3gl08wwa8zomfdfI',
    appId: '1:945355309896:android:be175299c1f4e1f839697d',
    messagingSenderId: '945355309896',
    projectId: 'chat-app-4157b',
    storageBucket: 'chat-app-4157b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-RBRorIJ1zh520U8doL5Oc-jpyeEyH94',
    appId: '1:945355309896:ios:55bff2b8a749a07f39697d',
    messagingSenderId: '945355309896',
    projectId: 'chat-app-4157b',
    storageBucket: 'chat-app-4157b.appspot.com',
    iosBundleId: 'com.example.scholarChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-RBRorIJ1zh520U8doL5Oc-jpyeEyH94',
    appId: '1:945355309896:ios:55bff2b8a749a07f39697d',
    messagingSenderId: '945355309896',
    projectId: 'chat-app-4157b',
    storageBucket: 'chat-app-4157b.appspot.com',
    iosBundleId: 'com.example.scholarChat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBF2398IdWbUNYPP0sDMokm9uEgvNXzT8U',
    appId: '1:945355309896:web:4bddf760c5ddc87039697d',
    messagingSenderId: '945355309896',
    projectId: 'chat-app-4157b',
    authDomain: 'chat-app-4157b.firebaseapp.com',
    storageBucket: 'chat-app-4157b.appspot.com',
    measurementId: 'G-KDF27F577J',
  );

}