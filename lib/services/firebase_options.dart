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
    apiKey: 'AIzaSyC0ry0o6e6Y-p0TACYlKr9eVRqhyv2ZGbc',
    appId: '1:350828900623:web:2c287e3d60667582e54e7a',
    messagingSenderId: '350828900623',
    projectId: 'lodione-lifestyle',
    authDomain: 'lodione-lifestyle.firebaseapp.com',
    databaseURL: 'https://lodione-lifestyle-default-rtdb.firebaseio.com',
    storageBucket: 'lodione-lifestyle.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASu97JPAaSPLMe5s8C6nas6JLVPReiuis',
    appId: '1:350828900623:android:30375d03fbf45120e54e7a',
    messagingSenderId: '350828900623',
    projectId: 'lodione-lifestyle',
    databaseURL: 'https://lodione-lifestyle-default-rtdb.firebaseio.com',
    storageBucket: 'lodione-lifestyle.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCY_4NJQ1Poa2F7Qhk-vM_Qo8J4DfNY7QI',
    appId: '1:350828900623:ios:2ab134e1bbd25c14e54e7a',
    messagingSenderId: '350828900623',
    projectId: 'lodione-lifestyle',
    databaseURL: 'https://lodione-lifestyle-default-rtdb.firebaseio.com',
    storageBucket: 'lodione-lifestyle.appspot.com',
    iosBundleId: 'com.example.lodione',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCY_4NJQ1Poa2F7Qhk-vM_Qo8J4DfNY7QI',
    appId: '1:350828900623:ios:2ab134e1bbd25c14e54e7a',
    messagingSenderId: '350828900623',
    projectId: 'lodione-lifestyle',
    databaseURL: 'https://lodione-lifestyle-default-rtdb.firebaseio.com',
    storageBucket: 'lodione-lifestyle.appspot.com',
    iosBundleId: 'com.example.lodione',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC0ry0o6e6Y-p0TACYlKr9eVRqhyv2ZGbc',
    appId: '1:350828900623:web:187cd8e224ab6c00e54e7a',
    messagingSenderId: '350828900623',
    projectId: 'lodione-lifestyle',
    authDomain: 'lodione-lifestyle.firebaseapp.com',
    databaseURL: 'https://lodione-lifestyle-default-rtdb.firebaseio.com',
    storageBucket: 'lodione-lifestyle.appspot.com',
  );

}