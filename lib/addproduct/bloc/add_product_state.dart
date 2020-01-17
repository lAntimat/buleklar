import 'package:buleklar/models/ProductItem.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

@immutable
class AddProductState {
  final bool isPriceValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool imageLoading;
  final List<Images> images;

  bool get isFormValid => isPriceValid;

  AddProductState({
    @required this.isPriceValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.imageLoading,
    @required this.images,
  });

  factory AddProductState.empty() {
    return AddProductState(
      isPriceValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      imageLoading: false,
      images: List(),
    );
  }

  AddProductState loading() {
    return copyWith(
      isPriceValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  AddProductState failure() {
    return copyWith(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  AddProductState itemAdded() {
    return copyWith(
      isPriceValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  AddProductState submitting() {
    return copyWith(
      isSubmitting: true
    );
  }

  AddProductState update({
    bool isPriceValid,
  }) {
    return copyWith(
      isPriceValid: isPriceValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  AddProductState updateImgUrl({
    List<Images> image,
  }) {
    return copyWith(
      isFailure: false,
      isSuccess: false,
      image: image,
    );
  }

  AddProductState imgLoading(bool loading) {
    return copyWith(
      imageLoading: loading,
    );
  }


  AddProductState copyWith({
    bool isPriceValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool imageLoading,
    List<Images> image,
  }) {
    return AddProductState(
      isPriceValid: isPriceValid ?? this.isPriceValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      imageLoading: imageLoading ?? this.imageLoading,
      images: image ?? this.images,
    );
  }

  @override
  String toString() {
    return '''AddProductState {
      isPriceValid: $isPriceValid,
      isSuccess: $isSuccess,
      isSubmitting: $isSubmitting,
      isFailure: $isFailure,
      imageLoading: $imageLoading,
      images: $images,
    }''';
  }
}
