import 'package:buleklar/models/ProductItem.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends AddProductEvent {
  final String name;

  const NameChanged({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'NameChanged { name :$name }';
}

class DescriptionChanged extends AddProductEvent {
  final String description;

  const DescriptionChanged({@required this.description});

  @override
  List<Object> get props => [description];

  @override
  String toString() => 'DescriptionChanged { description :$description }';
}

class PriceChanged extends AddProductEvent {
  final String price;

  const PriceChanged({@required this.price});

  @override
  List<Object> get props => [price];

  @override
  String toString() => 'PriceChanged { price: $price }';
}

class ImgUrlChanged extends AddProductEvent {
  final String imgUrl;

  const ImgUrlChanged({@required this.imgUrl});

  @override
  List<Object> get props => [imgUrl];

  @override
  String toString() => 'ImgUrlChanged { imgUrl: $imgUrl }';
}

class AddProductPressed extends AddProductEvent {
  final ProductItem productItem;

  const AddProductPressed({
    @required this.productItem,
  });

  @override
  List<Object> get props => [productItem];

  @override
  String toString() {
    return 'AddProductPressed { productItem: $productItem}';
  }
}
