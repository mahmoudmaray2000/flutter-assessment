import 'package:equatable/equatable.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity.dart';

abstract class PopularPeopleState extends Equatable {
  final int? page;
  const PopularPeopleState({required this.page});
  @override
  List<Object?> get props => [];
}

class PopularPeopleInitialState extends PopularPeopleState {
  const PopularPeopleInitialState({required super.page});

  @override
  List<Object?> get props => [];
}

class PopularPeopleLoadingState extends PopularPeopleState {
  const PopularPeopleLoadingState({required super.page});

  @override
  List<Object?> get props => [];
}

class PopularPeopleLoadedState extends PopularPeopleState {
  final List<PopularPeopleEntity> popularPeople;
  final int currentPage;
  final int totalPages;
  final bool isLoadingMore;

  const PopularPeopleLoadedState({
    required this.popularPeople,
    required this.currentPage,
    required this.totalPages,
    this.isLoadingMore = false,
  }) : super(page: currentPage);

  bool get hasMore => currentPage < totalPages;

  PopularPeopleLoadedState copyWith({
    List<PopularPeopleEntity>? popularPeople,
    int? currentPage,
    int? totalPages,
    bool? isLoadingMore,
  }) {
    return PopularPeopleLoadedState(
      popularPeople: popularPeople ?? this.popularPeople,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    popularPeople,
    currentPage,
    totalPages,
    isLoadingMore,
  ];
}

class PopularPeopleErrorState extends PopularPeopleState {
  final String errorMessage;
  const PopularPeopleErrorState({required this.errorMessage, required super.page});
  @override
  List<Object?> get props => [errorMessage];
}