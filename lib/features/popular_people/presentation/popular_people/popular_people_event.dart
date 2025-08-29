import 'package:equatable/equatable.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity.dart';

abstract class PopularPeopleEvent extends Equatable {}

class FetchPopularPeopleEvent extends PopularPeopleEvent {
  final int page;

  FetchPopularPeopleEvent({required this.page});

  @override
  List<Object?> get props => [page];
}

class LoadMorePopularPeopleEvent extends PopularPeopleEvent {
  @override
  List<Object?> get props => [];
}

class LoadCachedPopularPeopleEvent extends PopularPeopleEvent {
  final int page;

  LoadCachedPopularPeopleEvent({required this.page});

  @override
  List<Object?> get props => [page];
}

class CachedLocalDataEvent extends PopularPeopleEvent {
  final int page;
  final List<PopularPeopleEntity> popularPeople;

  CachedLocalDataEvent({required this.page, required this.popularPeople});

  @override
  List<Object?> get props => [page, popularPeople];
}

class FetchPopularAllPeopleEvent extends PopularPeopleEvent {
  final int page;
  FetchPopularAllPeopleEvent({required this.page});
  @override
  List<Object?> get props => [page];
}
