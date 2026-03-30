import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCf0D3RdNskSqpHSunJhUQNr-bP0T2nRy4',
    appId: '1:647468449079:web:a98b84afde5e85a196fc6',
    messagingSenderId: '647468449079',
    projectId: 'smartyatra-e60ad',
    authDomain: 'smartyatra-e60ad.firebaseapp.com',
    storageBucket: 'smartyatra-e60ad.firebasestorage.app',
  );
}
