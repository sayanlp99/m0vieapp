import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreDatabase {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance.currentUser;

  Future<void> addToFavourite(String id, String type) async {
    if (type == "movie") {
      db.collection('favourites').doc(auth!.uid).get().then((value) {
        if (value.exists) {
          db.collection('favourites').doc(auth!.uid).update({
            'movies': FieldValue.arrayUnion([id])
          });
        } else {
          db.collection('favourites').doc(auth!.uid).set({
            'movies': [id]
          });
        }
      });
    } else {
      db.collection('favourites').doc(auth!.uid).get().then((value) {
        if (value.exists) {
          db.collection('favourites').doc(auth!.uid).update({
            'tvshows': FieldValue.arrayUnion([id])
          });
        } else {
          db.collection('favourites').doc(auth!.uid).set({
            'tvshows': [id]
          });
        }
      });
    }
  }

  Future<void> removeFromFavourite(String id, String type) async {
    if (type == "movie") {
      await db.collection('favourites').doc(auth!.uid).update({
        'movies': FieldValue.arrayRemove([id])
      });
    } else {
      await db.collection('favourites').doc(auth!.uid).update({
        'tvshows': FieldValue.arrayRemove([id])
      });
    }
  }

  Future<bool>? checkFavourite(String id, String type) async {
    if (type == "movie") {
      var result = await db
          .collection('favourites')
          .doc(auth!.uid)
          .get()
          .then((value) => value.data()!['movies']);
      if (result != null) {
        debugPrint('result: $result');
        return result.contains(id);
      } else {
        debugPrint('result: $result');
        return false;
      }
    } else {
      var result = await db
          .collection('favourites')
          .doc(auth!.uid)
          .get()
          .then((value) => value.data()!['tvshows']);
      if (result != null) {
        debugPrint('result: $result');
        return result.contains(id);
      } else {
        debugPrint('result: $result');
        return false;
      }
    }
  }
}
