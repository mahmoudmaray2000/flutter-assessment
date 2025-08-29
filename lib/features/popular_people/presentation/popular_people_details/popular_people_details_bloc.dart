import 'package:bloc/bloc.dart';
import 'package:flutter_assessment/features/popular_people/domain/use_case/fetch_popular_details_use_cae.dart';
import 'popular_people_details_event.dart';
import 'popular_people_details_state.dart';

class PopularPeopleDetailsBloc
    extends Bloc<PopularPeopleDetailsEvent, PopularPeopleDetailsState> {
  final FetchPopularDetailsUseCase _fetchPopularDetailsUseCase;

  PopularPeopleDetailsBloc(this._fetchPopularDetailsUseCase)
    : super(PopularPeopleDetailsInitialState()) {
    on<FetchPopularPeopleDetailsEvent>(_fetchDetails);
  }

  void _fetchDetails(
    FetchPopularPeopleDetailsEvent event,
    Emitter<PopularPeopleDetailsState> emit,
  ) async {
    emit(PopularPeopleDetailsLoadingState());
    final result = await _fetchPopularDetailsUseCase.call(id: event.personId);
    result.fold(
      (error) =>
          emit(PopularPeopleDetailsErrorState(errorMessage: error.message)),
      (details) => emit(PopularPeopleDetailsLoadedState(details: details)),
    );
  }
}
