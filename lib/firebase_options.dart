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
    apiKey: 'AIzaSyA5l527wyH8J_XAZ5MpQh3zQV2lRUtZcuQ',
    appId: '1:365442424779:web:e9acecc263cabcc55c604e',
    messagingSenderId: '365442424779',
    projectId: 'doctor-d2',
    authDomain: 'doctor-d2.firebaseapp.com',
    storageBucket: 'doctor-d2.firebasestorage.app',
    measurementId: 'G-3JTTTREQ6X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAi--dqwvT_uqcXc88AzhpS42-A1u7Ech0',
    appId: '1:365442424779:android:02f109616e156a255c604e',
    messagingSenderId: '365442424779',
    projectId: 'doctor-d2',
    storageBucket: 'doctor-d2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLQe7Tw67L1K7TFxQZW40JrrK7y1bSYHk',
    appId: '1:365442424779:ios:807e4fdb00a5b5075c604e',
    messagingSenderId: '365442424779',
    projectId: 'doctor-d2',
    storageBucket: 'doctor-d2.firebasestorage.app',
    iosBundleId: 'com.example.d2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLQe7Tw67L1K7TFxQZW40JrrK7y1bSYHk',
    appId: '1:365442424779:ios:807e4fdb00a5b5075c604e',
    messagingSenderId: '365442424779',
    projectId: 'doctor-d2',
    storageBucket: 'doctor-d2.firebasestorage.app',
    iosBundleId: 'com.example.d2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA5l527wyH8J_XAZ5MpQh3zQV2lRUtZcuQ',
    appId: '1:365442424779:web:8f03e3e94ad2b0d25c604e',
    messagingSenderId: '365442424779',
    projectId: 'doctor-d2',
    authDomain: 'doctor-d2.firebaseapp.com',
    storageBucket: 'doctor-d2.firebasestorage.app',
    measurementId: 'G-6FPPW8KTSF',
  );
}