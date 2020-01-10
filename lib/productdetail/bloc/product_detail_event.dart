import 'package:buleklar/models/ProductItem.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends ProductDetailEvent {

  final String id;
  const LoadData(this.id);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'LoadData';
}


class ImageClicked extends ProductDetailEvent {
  final String id;

  const ImageClicked({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ImageClicked { id :$id }';
}
