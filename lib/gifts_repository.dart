import 'dart:async';
import 'dart:io';
import 'package:buleklar/models/ImageCarousel.dart';
import 'package:buleklar/models/ProductItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:insta_html_parser/insta_html_parser.dart';
import 'package:path/path.dart' as Path;

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

  Future<List<ProductItem>> getProducts() async {
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

  Future<ProductItem> getProduct(String id) async {
    var result;
    await _firestore
        .collection("gifts").document(id).get()
        .then((data) {
      if (data.data.isNotEmpty == true) {
        result = ProductItem.fromDocument(data.documentID, data.data);
      } else {
        throw "empty categories";
      }
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

  Future<String> uploadFile(File _image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    uploadTask.events.listen((data) {
      if(data.type == StorageTaskEventType.progress) {
        print(data);
      }
    });
    await uploadTask.onComplete;
    print('File Uploaded');
    return await storageReference.getDownloadURL();
  }
}
