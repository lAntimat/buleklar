import 'dart:async';
import 'package:buleklar/models/ImageCarousel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final Firestore _firestore;

  UserRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  Future<List<ImageCarousel>> getCarousel() async {
    var result;
    await _firestore
        .collection("image_carousel")
        .orderBy("order", descending: false)
        .getDocuments()
        .then((data) {
      if (data.documents.isNotEmpty == true) {
        List<ImageCarousel> ar = List();
        data.documents.forEach((f) {
          ar.add(ImageCarousel.fromDocument(f));
        });
        result = ar;
      } else {
        throw Error();
      }
    });

    return result;
  }
}
