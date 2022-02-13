import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gift_server/domain/entity/wishyou_entity.dart';

class WishsFirebaseDataSourse {
  late FirebaseFirestore firestore;
  late CollectionReference wishs;

  WishsFirebaseDataSourse.initialize() {
    initDB();
  }

  Future<void> initDB() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDL0QZsQREJ7hUbUzYrp3YCX1Te44pl0Jg',
          appId: '1:479333694375:web:234affaf4591cbbc761482',
          authDomain: "geftapp.firebaseapp.com",
          messagingSenderId: '479333694375',
          projectId: 'geftapp',
          storageBucket: 'geftapp.appspot.com',
          measurementId: "G-DHF5TJJG1G"
          //databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
          //iosClientId:
          //    '448618578101-dgsgte6oqc377gdf80gbb8ovtjbagi49.apps.googleusercontent.com',
          //iosBundleId: 'io.flutter.plugins.firebase.storage.example',
          ),
    );

    firestore = FirebaseFirestore.instance;
    wishs = FirebaseFirestore.instance.collection('wishs');
  }

  Future<void> addWishYou(String wishYou, DateTime date) async {
    wishs.add({
      'wishyou': wishYou,
      'date': date // Stokes and Sons
    });
  }
}
