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
    apiKey: 'AIzaSyBg7sOMzy6U3FxJdeTfZO-LQm_6dEUSFGI',
    appId: '1:202237398081:web:b6b5372ef389d4e0064ac0',
    messagingSenderId: '202237398081',
    projectId: 'proyecto-dam-35f47',
    authDomain: 'proyecto-dam-35f47.firebaseapp.com',
    storageBucket: 'proyecto-dam-35f47.appspot.com',
    measurementId: 'G-RLWFXFPR1G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDp_nQl25U0sXnOsRnRKMJJPQN5eUzZ_0U',
    appId: '1:202237398081:android:fe0292e11f6f6dab064ac0',
    messagingSenderId: '202237398081',
    projectId: 'proyecto-dam-35f47',
    storageBucket: 'proyecto-dam-35f47.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIqsLsZFT7NyHnJGkoOKmL4hnQvj81RbA',
    appId: '1:202237398081:ios:f47c73637bfc3ac4064ac0',
    messagingSenderId: '202237398081',
    projectId: 'proyecto-dam-35f47',
    storageBucket: 'proyecto-dam-35f47.appspot.com',
    iosClientId: '202237398081-bb49vncl4e2dkljmdmlnt3n2peb42bvd.apps.googleusercontent.com',
    iosBundleId: 'com.example.proyectoFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBIqsLsZFT7NyHnJGkoOKmL4hnQvj81RbA',
    appId: '1:202237398081:ios:9cb8d3668be211d0064ac0',
    messagingSenderId: '202237398081',
    projectId: 'proyecto-dam-35f47',
    storageBucket: 'proyecto-dam-35f47.appspot.com',
    iosClientId: '202237398081-svg4ip4ejmqfbtcu7e4f25f0m4hhu7qh.apps.googleusercontent.com',
    iosBundleId: 'com.example.proyectoFlutter.RunnerTests',
  );
}