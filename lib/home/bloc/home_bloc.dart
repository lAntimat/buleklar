import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buleklar/gifts_repository.dart';
import 'package:buleklar/user_repository.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepository;
  final GiftsRepository _giftRepository;

  HomeBloc(
      {@required UserRepository userRepository,
      @required GiftsRepository giftsRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _giftRepository = giftsRepository;

  @override
  HomeState get initialState => HomeState.empty();

  @override
  Stream<HomeState> transformEvents(
    Stream<HomeEvent> events,
    Stream<HomeState> Function(HomeEvent event) next,
  ) {
    return super.transformEvents(events, next);
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadData) {
      yield* _mapLoadCarouselToState(state);
      yield* _mapLoadCategoriesToState(state);
    } else if(event is FabClicked) {
      yield* _mapFabClickedToState(state);
    } else if(event is ProductClicked) {
      yield* _mapProductClickedToState(event.id);

    }
  }

  Stream<HomeState> _mapLoadCarouselToState(HomeState currentState) async* {
    yield HomeState.loading();
    try {
      var items = await _giftRepository.getCarousel();
      yield HomeState.dataLoaded(carouselItems: items, items: currentState.categories);
    } catch (error) {
      yield HomeState.failure(error: error);
    }
  }

  Stream<HomeState> _mapLoadCategoriesToState(HomeState currentState) async* {
    yield HomeState.loading();
    try {
      var items = await _giftRepository.getProducts();
      yield HomeState.dataLoaded(carouselItems: currentState.carouselItems, items: items);
    } catch (error) {
      yield HomeState.failure(error: error);
    }
  }

  Stream<HomeState> _mapFabClickedToState(HomeState currentState) async* {
    yield HomeState.fabClicked(currentState.copyWith(isFabClicked: true));
  }

  Stream<HomeState> _mapProductClickedToState(String id) async* {
    yield state.productClicked(id);
  }
}
