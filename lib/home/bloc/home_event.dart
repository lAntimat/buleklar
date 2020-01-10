import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends HomeEvent {

  const LoadData();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoadData';
}

class FabClicked extends HomeEvent {}

class ProductClicked extends HomeEvent {
  final String id;

  ProductClicked(this.id);
}
