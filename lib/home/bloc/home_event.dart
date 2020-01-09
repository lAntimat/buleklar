import 'package:equatable/equatable.dart';

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
