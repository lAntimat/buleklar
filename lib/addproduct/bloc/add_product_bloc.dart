import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buleklar/gifts_repository.dart';
import 'package:buleklar/models/ProductItem.dart';
import 'package:buleklar/user_repository.dart';
import 'package:buleklar/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  UserRepository _userRepository;
  GiftsRepository _giftsRepository;

  AddProductBloc({
    @required UserRepository userRepository,
    @required GiftsRepository giftsRepository,
  })  : assert(userRepository != null),
        assert(giftsRepository != null),
        _userRepository = userRepository,
        _giftsRepository = giftsRepository;

  @override
  AddProductState get initialState => AddProductState.empty();

  @override
  Stream<AddProductState> transformEvents(
    Stream<AddProductEvent> events,
    Stream<AddProductState> Function(AddProductEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return !(event is NameChanged ||
          event is DescriptionChanged ||
          event is PriceChanged ||
          event is ImgUrlChanged);
    });
    final debounceStream = events.where((event) {
      return (event is NameChanged ||
          event is DescriptionChanged ||
          event is PriceChanged ||
          event is ImgUrlChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<AddProductState> mapEventToState(AddProductEvent event) async* {
    if (event is PriceChanged) {
      yield* _mapPrice(event.price);
    } else if (event is AddProductPressed) {
      yield* _mapAddProduct(event.productItem);
    } else if (event is ImgUrlChanged) {
      //var image = await _giftsRepository.parseInstragamPost(event.imgUrl);
      //yield* _mapImgUrl(image.medium);
    } else if (event is LoadFilePressed) {
      yield* mapImgLoading(true);
      var image = await _giftsRepository.uploadFile(event.img)
      .catchError((error) {
        print(error);
      });
      yield* _mapImgUrl(image);
    }
  }

  Stream<AddProductState> _mapPrice(String price) async* {
    yield state.update(
      isPriceValid: Validators.isDigits(price),
    );
  }

  Stream<AddProductState> _mapImgUrl(String imgUrl) async* {
    var images = List();
    if(state.images != null) images = state.images;
    images.add(Images(imgUrl, imgUrl, imgUrl));
    yield state.imgLoading(false);
    yield state.updateImgUrl(
        image: images
    );
  }

  Stream<AddProductState> mapImgLoading(bool loading) async* {
    yield state.imgLoading(loading);
  }

  Stream<AddProductState> _mapAddProduct(ProductItem productItem) async* {
    try {
      yield state.submitting();
      productItem.images = state.images;
      await _giftsRepository.addProduct(productItem);
      yield state.itemAdded();
    } catch (_) {
      yield state.failure();
    }
  }
}
