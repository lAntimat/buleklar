import 'package:buleklar/models/ProductItem.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

@immutable
class ProductDetailState {
  final bool isLoading;
  final ProductItem productItem;

  ProductDetailState({
    @required this.isLoading,
    @required this.productItem,
  });

  factory ProductDetailState.empty() {
    return ProductDetailState(
      isLoading: false,
      productItem: null,
    );
  }

  ProductDetailState loading() {
    return copyWith(isLoading: true);
  }

  ProductDetailState productsLoaded(ProductItem productItem) {
    return copyWith(
      productItem: productItem,
      isLoading: false,
    );
  }

  ProductDetailState copyWith({
    ProductItem productItem,
    bool isLoading,
  }) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      productItem: productItem ?? this.productItem,
    );
  }

  @override
  String toString() {
    return '''ProductDetailState {
      isLoading: $isLoading
      productItem: $productItem,
    }''';
  }
}
