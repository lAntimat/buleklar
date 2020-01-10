import 'package:buleklar/models/ProductItem.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

@immutable
class AddProductState {
  final bool isPriceValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final Images image;

  bool get isFormValid => isPriceValid;

  AddProductState({
    @required this.isPriceValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.image,
  });

  factory AddProductState.empty() {
    return AddProductState(
      isPriceValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      image: null,
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
    Images image,
  }) {
    return copyWith(
      isFailure: false,
      isSuccess: false,
      image: image,
    );
  }


  AddProductState copyWith({
    bool isPriceValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    Images image,
  }) {
    return AddProductState(
      isPriceValid: isPriceValid ?? this.isPriceValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return '''AddProductState {
      isPriceValid: $isPriceValid,
      isSuccess: $isSuccess,
      isSubmitting: $isSubmitting,
      isFailure: $isFailure,
      images: $image,
    }''';
  }
}
