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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB368vxV3A3qojO6p_Wlyt6jjDFKOWP7_0',
    appId: '1:354908969166:web:9f1cd18f62e5e3e2df589f',
    messagingSenderId: '354908969166',
    projectId: 'batatis14-ab827',
    authDomain: 'batatis14-ab827.firebaseapp.com',
    storageBucket: 'batatis14-ab827.appspot.com',
    measurementId: 'G-G25MJ4W9R5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbEUF14573ijBu7dc5BF216IiI7GTSAhA',
    appId: '1:354908969166:android:d412cb040b3c7c70df589f',
    messagingSenderId: '354908969166',
    projectId: 'batatis14-ab827',
    storageBucket: 'batatis14-ab827.appspot.com',
  );
}