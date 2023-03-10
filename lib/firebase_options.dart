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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDnom8iFcvuEAROpIj1Rw9QkFiv4o28CBY',
    appId: '1:829041914131:android:7c95d1a159e16078b26ae6',
    messagingSenderId: '829041914131',
    projectId: 'businessmates-bbc29',
    storageBucket: 'businessmates-bbc29.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXRGkmIMD9BYRd8jT78icxtDbq_cOJ_ls',
    appId: '1:829041914131:ios:ca20fbea6bf74d10b26ae6',
    messagingSenderId: '829041914131',
    projectId: 'businessmates-bbc29',
    storageBucket: 'businessmates-bbc29.appspot.com',
    androidClientId: '829041914131-f9b4v0pcloo5jtdq8hvfafbm6sar3k1u.apps.googleusercontent.com',
    iosClientId: '829041914131-2266dr0s2ndlgdmegq64df3ma7akvpn7.apps.googleusercontent.com',
    iosBundleId: 'com.example.businessmatesAdmin',
  );
}
