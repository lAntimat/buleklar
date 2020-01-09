import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductItem {
  String id;
  String name = "";
  String description = "";
  int price = 0;
  Images image;


  ProductItem(this.name, this.description, this.price, this.image);

  ProductItem.withId(this.id, this.name, this.description, this.price, this.image);

  factory ProductItem.fromDocument(String id, Map<String, dynamic> d) {
    return new ProductItem.withId(
        id, d["name"], d["description"], d["price"], Images.fromMap(d["image"]));
  }

  @override
  String toString() {
    return name;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'image': this.image.toMap(),
  };
  }

}

class Images {
  String small;
  String medium;
  String large;

  Images(this.small, this.medium, this.large);

  factory Images.fromInstagram(Map<String, String> d) {
    return new Images(d["small"], d["medium"], d["large"]);
  }

  factory Images.fromMap(LinkedHashMap<dynamic, dynamic> d) {
    return new Images(d["small"], d["medium"], d["large"]);
  }

  @override
  String toString() {
    return small;
  }

  Map<String, dynamic> toMap() {
    return {
      'small': this.small,
      'medium': this.medium,
      'large': this.large,
    };
  }


}
