import 'package:bloc/bloc.dart';
import 'package:flutter_assessment/core/connection/check_connection.dart';
import 'package:flutter_assessment/features/popular_people/domain/use_case/fetch_popular_use_case.dart';
import 'package:flutter_assessment/features/popular_people/domain/use_case/local_popular_use_case.dart';

import 'popular_people_event.dart';
import 'popular_people_state.dart';

class PopularPeopleBloc extends Bloc<PopularPeopleEvent, PopularPeopleState> {
  final FetchPopularUseCase _fetchPopularUseCase;
  final LocalPopularUseCase _localPopularUseCase;
  final ConnectionService _connectionService;

  PopularPeopleBloc(
    this._fetchPopularUseCase,
    this._localPopularUseCase,
    this._connectionService,
  ) : super(PopularPeopleInitialState(page: 1)) {
    on<FetchPopularPeopleEvent>(_fetchPopularPeople);
    on<LoadMorePopularPeopleEvent>(_loadMorePopularPeople);
    on<LoadCachedPopularPeopleEvent>(_loadCachedPopularPeople);
    on<CachedLocalDataEvent>(_cachedLocalData);
    on<FetchPopularAllPeopleEvent>(_fetchAllData);
  }

  void _fetchAllData(
    FetchPopularAllPeopleEvent event,
    Emitter<PopularPeopleState> emit,
  ) async {
    final isConnected = await _connectionService.isConnected;
    if (isConnected==false) {
      add(FetchPopularPeopleEvent(page: event.page));
    } else {
      add(LoadCachedPopularPeopleEvent(page: event.page));
    }
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
      (response) {
        emit(
          PopularPeopleLoadedState(
            popularPeople: response.results!,
            currentPage: response.page ?? 1,
            totalPages: response.totalPages ?? 1,
          ),
        );
        add(
          CachedLocalDataEvent(
            page: response.page ?? 1,
            popularPeople: response.results!,
          ),
        );
      },
    );
  }

  void _cachedLocalData(
    CachedLocalDataEvent event,
    Emitter<PopularPeopleState> emit,
  ) async {
    await _localPopularUseCase.execute(
      page: event.page,
      people: event.popularPeople,
    );
  }

  void _loadMorePopularPeople(
    LoadMorePopularPeopleEvent event,
    Emitter<PopularPeopleState> emit,
  ) async {
    final currentState = state;
    if (currentState is PopularPeopleLoadedState && currentState.hasMore) {
      emit(currentState.copyWith(isLoadingMore: true));
      final result = await _fetchPopularUseCase.call(
        page: currentState.currentPage + 1,
      );
      result.fold(
        (error) => emit(
          PopularPeopleErrorState(
            errorMessage: error.message,
            page: currentState.currentPage + 1,
          ),
        ),
        (response) {
          emit(
            currentState.copyWith(
              popularPeople: currentState.popularPeople + response.results!,
              currentPage: response.page ?? currentState.currentPage + 1,
              isLoadingMore: false,
            ),
          );
          add(
            CachedLocalDataEvent(
              page: response.page ?? 1,
              popularPeople: response.results!,
            ),
          );
        },
      );
    }
  }

  void _loadCachedPopularPeople(
    LoadCachedPopularPeopleEvent event,
    Emitter<PopularPeopleState> emit,
  ) async {
    emit(PopularPeopleLoadingState(page: event.page));
    await Future<void>.delayed( Duration(milliseconds: 16));
    final result = await _localPopularUseCase.call();
    result.fold(
      (error) => emit(
        PopularPeopleErrorState(errorMessage: error.message, page: event.page),
      ),
      (response) => emit(
        PopularPeopleLoadedState(
          popularPeople: response,
          currentPage: event.page,
          totalPages: 1,
        ),
      ),
    );
  }
}
