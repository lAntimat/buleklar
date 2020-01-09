import 'dart:async';
import 'package:buleklar/models/ImageCarousel.dart';
import 'package:buleklar/models/ProductItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insta_html_parser/insta_html_parser.dart';

class GiftsRepository {
  final Firestore _firestore;

  GiftsRepository({Firestore firestore})
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
        throw "empty carousel";
      }
    }).catchError((onError) {
      throw onError;
    });

    return result;
  }

  Future<List<ProductItem>> getCategories() async {
    var result;
    await _firestore
        .collection("gifts")
        .getDocuments()
        .then((data) {
      if (data.documents.isNotEmpty == true) {
        List<ProductItem> ar = List();
        data.documents.forEach((f) {
          ar.add(ProductItem.fromDocument(f.documentID, f.data));
        });
        result = ar;
      } else {
        throw "empty categories";
      }
    }).catchError((onError) {
      throw onError;
    });

    return result;
  }

  Future<bool> addProduct(ProductItem productItem) async {
    var result = false;
    await _firestore
        .collection("gifts")
        .add(productItem.toMap())
        .then((data) {
          result = true;
          print('add success $data');
    }).catchError((onError) {
      throw onError;
    });

    return result;
  }

  Future<Images> parseInstragamPost(String url) async {
    var data = await InstaParser.photoUrlsFromPost(url);
    return Images.fromInstagram(data);
  }
}
