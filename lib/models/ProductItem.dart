import 'dart:collection';

class ProductItem {
  String id;
  String name = "";
  String description = "";
  int price = 0;
  List<Images> images;

  ProductItem(this.name, this.description, this.price, this.images);

  ProductItem.withId(
      this.id, this.name, this.description, this.price, this.images);

  factory ProductItem.fromDocument(String id, Map<String, dynamic> d) {
    return new ProductItem.withId(id, d["name"], d["description"], d["price"],
        d["image"].map<Images>((d) => Images.fromMap(d)).toList());
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
      'image': this.images.map((f) => f.toMap()).toList(),
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
