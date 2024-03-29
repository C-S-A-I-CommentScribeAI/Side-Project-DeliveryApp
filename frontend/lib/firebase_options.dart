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
    apiKey: 'AIzaSyCIjQ736xrsiEGOzx8dRmSsxVb8YWKXudI',
    appId: '1:425892227525:web:c2651365fb4ef25e5dc3ac',
    messagingSenderId: '425892227525',
    projectId: 'side-project-delieveryap-9d898',
    authDomain: 'side-project-delieveryap-9d898.firebaseapp.com',
    storageBucket: 'side-project-delieveryap-9d898.appspot.com',
    measurementId: 'G-M6RYQQT8WV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvBwh8GlYEtwk7g0dPZVCHLrVyyHGwnY0',
    appId: '1:425892227525:android:d5b002d8f7d38e265dc3ac',
    messagingSenderId: '425892227525',
    projectId: 'side-project-delieveryap-9d898',
    storageBucket: 'side-project-delieveryap-9d898.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCc03Dzwk4xYwALXhv-7YFw6JF9FNurWJc',
    appId: '1:425892227525:ios:c5eaf152a200f4605dc3ac',
    messagingSenderId: '425892227525',
    projectId: 'side-project-delieveryap-9d898',
    storageBucket: 'side-project-delieveryap-9d898.appspot.com',
    iosBundleId: 'com.example.frontend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCc03Dzwk4xYwALXhv-7YFw6JF9FNurWJc',
    appId: '1:425892227525:ios:df6f831af240e9015dc3ac',
    messagingSenderId: '425892227525',
    projectId: 'side-project-delieveryap-9d898',
    storageBucket: 'side-project-delieveryap-9d898.appspot.com',
    iosBundleId: 'com.example.frontend.RunnerTests',
  );
}
