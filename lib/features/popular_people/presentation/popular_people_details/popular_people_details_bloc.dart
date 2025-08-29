import 'package:bloc/bloc.dart';
import 'package:flutter_assessment/core/storage/image_service/image_service.dart';
import 'package:flutter_assessment/features/popular_people/domain/use_case/fetch_popular_details_use_cae.dart';

import 'popular_people_details_event.dart';
import 'popular_people_details_state.dart';

class PopularPeopleDetailsBloc
    extends Bloc<PopularPeopleDetailsEvent, PopularPeopleDetailsState> {
  final FetchPopularDetailsUseCase _fetchPopularDetailsUseCase;
  final ImageSaverService _imageSaverService;

  PopularPeopleDetailsBloc(
    this._fetchPopularDetailsUseCase,
    this._imageSaverService,
  ) : super(PopularPeopleDetailsInitialState()) {
    on<FetchPopularPeopleDetailsEvent>(_fetchDetails);
    on<DownloadImageEvent>(_downloadImage);
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

  void _downloadImage(
    DownloadImageEvent event,
    Emitter<PopularPeopleDetailsState> emit,
  ) async {
    emit(ImageDownloadInProgressState());
    final result = await _imageSaverService.saveFromUrl(
      event.imageUrl,
      name: event.imageUrl.split('/').last,
    );
    if (result.success) {
      emit(ImageDownloadSuccessState(filePath: result.filePath!));
    } else {
      emit(ImageDownloadErrorState(errorMessage: result.message!));
    }
  }
}
