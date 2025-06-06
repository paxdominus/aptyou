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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyClohj6uzQ5aaBd4ezR6cKBp66pWaYj1s4',
    appId: '1:547292429499:web:5c680bd833494c39923d9e',
    messagingSenderId: '547292429499',
    projectId: 'aptyou-19c11',
    authDomain: 'aptyou-19c11.firebaseapp.com',
    storageBucket: 'aptyou-19c11.firebasestorage.app',
    measurementId: 'G-SD0Z88DC16',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDlTtj6-6cR3864gqVdWJiJTSWxb_Txqsg',
    appId: '1:547292429499:android:a0d08ed3d543f14a923d9e',
    messagingSenderId: '547292429499',
    projectId: 'aptyou-19c11',
    storageBucket: 'aptyou-19c11.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfjF18tumrrWMbcM9C6ziuE3VPJWK0BWI',
    appId: '1:547292429499:ios:eade58c13bbfacb8923d9e',
    messagingSenderId: '547292429499',
    projectId: 'aptyou-19c11',
    storageBucket: 'aptyou-19c11.firebasestorage.app',
    androidClientId: '547292429499-kl2e42lc4m7hlvl4dunrtjc2kc7hf877.apps.googleusercontent.com',
    iosClientId: '547292429499-odoj81kgahfhj38693120gbdrkhe97tu.apps.googleusercontent.com',
    iosBundleId: 'com.example.aptyouEd',
  );

}