import 'package:buleklar/models/ImageCarousel.dart';
import 'package:buleklar/models/ProductItem.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

@immutable
class HomeState {
  final bool isSuccess;
  final bool isFailure;
  final bool isFabClicked;
  final bool isProductClicked;
  final String clickedId;
  final String errorText;
  final List<ImageCarousel> carouselItems;
  final List<ProductItem> categories;

  HomeState(
      {@required this.isSuccess,
      @required this.isFailure,
      @required this.carouselItems,
      @required this.categories,
      @required this.isFabClicked,
      @required this.isProductClicked,
      @required this.clickedId,
      @required this.errorText});

  factory HomeState.empty() {
    return HomeState(
      isSuccess: false,
      isFailure: false,
      errorText: "",
      carouselItems: <ImageCarousel>[],
      categories: <ProductItem>[],
      isFabClicked: false,
      isProductClicked: false,
      clickedId: null,
    );
  }

  factory HomeState.loading() {
    return HomeState(
      isSuccess: false,
      isFailure: false,
      errorText: "",
      carouselItems: <ImageCarousel>[],
      categories: <ProductItem>[],
      isFabClicked: false,
      isProductClicked: false,
      clickedId: null,
    );
  }

  factory HomeState.failure({String error}) {
    return HomeState(
      isSuccess: false,
      isFailure: true,
      errorText: "",
      carouselItems: <ImageCarousel>[],
      categories: <ProductItem>[],
      isFabClicked: false,
      isProductClicked: false,
      clickedId: null,
    );
  }

  factory HomeState.fabClicked(HomeState homeState) {
    return homeState;
  }

  HomeState productClicked(String id) {
    return copyWith(
      clickedId: id,
      isProductClicked: true
    );
  }

  factory HomeState.dataLoaded(
      {List<ImageCarousel> carouselItems, List<ProductItem> items}) {
    return HomeState(
      isSuccess: true,
      isFailure: false,
      isFabClicked: false,
      errorText: "",
      carouselItems: carouselItems,
      categories: items,
      isProductClicked: false,
      clickedId: null,
    );
  }

  HomeState copyWith({
    List<ImageCarousel> carouselItems,
    List<ProductItem> categories,
    bool isSuccess,
    bool isFailure,
    String errorText,
    bool isFabClicked,
    bool isProductClicked,
    String clickedId,
  }) {
    return HomeState(
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorText: errorText ?? this.errorText,
      carouselItems: carouselItems ?? this.carouselItems,
      categories: categories ?? this.categories,
      isFabClicked: isFabClicked ?? false,
      isProductClicked: isProductClicked ?? false,
      clickedId: clickedId ?? this.clickedId,
    );
  }

  @override
  String toString() {
    return '''HomeState {
      carouselItems: $carouselItems
      products: $categories
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      errorText: $errorText,
      isFabClicked: $isFabClicked,
    }''';
  }
}
