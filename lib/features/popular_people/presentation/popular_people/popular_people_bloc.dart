import 'package:bloc/bloc.dart';
import 'package:flutter_assessment/features/popular_people/domain/use_case/fetch_popular_use_case.dart';

import 'popular_people_event.dart';
import 'popular_people_state.dart';

class PopularPeopleBloc extends Bloc<PopularPeopleEvent, PopularPeopleState> {
  final FetchPopularUseCase _fetchPopularUseCase;

  PopularPeopleBloc(this._fetchPopularUseCase)
      : super(PopularPeopleInitialState(page: 1)) {
    on<FetchPopularPeopleEvent>(_fetchPopularPeople);
    on<LoadMorePopularPeopleEvent>(_loadMorePopularPeople);
  }

  void _fetchPopularPeople(
      FetchPopularPeopleEvent event,
      Emitter<PopularPeopleState> emit,
      ) async {
    emit(PopularPeopleLoadingState(page: event.page));
    final result = await _fetchPopularUseCase.call(page: event.page);
    result.fold(
          (error) => emit(
        PopularPeopleErrorState(errorMessage: error.message, page: event.page),
      ),
          (response) => emit(
        PopularPeopleLoadedState(
          popularPeople: response.results!,
          currentPage: response.page ?? 1,
          totalPages: response.totalPages ?? 1,
        ),
      ),
    );
  }

  void _loadMorePopularPeople(
      LoadMorePopularPeopleEvent event,
      Emitter<PopularPeopleState> emit,
      ) async {
    final currentState = state;
    if (currentState is PopularPeopleLoadedState && currentState.hasMore) {
      emit(currentState.copyWith(isLoadingMore: true));
      final result = await _fetchPopularUseCase.call(page: currentState.currentPage + 1);
      result.fold(
            (error) => emit(
          PopularPeopleErrorState(
            errorMessage: error.message,
            page: currentState.currentPage + 1,
          ),
        ),
            (response) => emit(
          currentState.copyWith(
            popularPeople: currentState.popularPeople + response.results!,
            currentPage: response.page ?? currentState.currentPage + 1,
            isLoadingMore: false,
          ),
        ),
      );
    }
  }
}