import 'package:equatable/equatable.dart';

abstract class PopularPeopleEvent extends Equatable{}

class FetchPopularPeopleEvent extends PopularPeopleEvent {
  final int page;

  FetchPopularPeopleEvent({required this.page});

  @override
  List<Object?> get props =>  [page];
}

class LoadMorePopularPeopleEvent extends PopularPeopleEvent {
  @override
  List<Object?> get props => [];
}
