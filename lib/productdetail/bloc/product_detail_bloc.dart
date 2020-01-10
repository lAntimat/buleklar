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

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  UserRepository _userRepository;
  GiftsRepository _giftsRepository;

  ProductDetailBloc({
    @required UserRepository userRepository,
    @required GiftsRepository giftsRepository,
  })  : assert(userRepository != null),
        assert(giftsRepository != null),
        _userRepository = userRepository,
        _giftsRepository = giftsRepository;

  @override
  ProductDetailState get initialState => ProductDetailState.empty();


  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is LoadData) {
      yield* _mapLoadData(event.id);
    }
  }


  Stream<ProductDetailState> _mapLoadData(String id) async* {
    try {
      yield state.loading();
      var product = await _giftsRepository.getProduct(id);
      yield state.productsLoaded(product);
    } catch (e) {
      //yield state.failure();
      print(e);
    }
  }
}
