import 'package:equatable/equatable.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_details_entity.dart';

sealed class PopularPeopleDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopularPeopleDetailsInitialState extends PopularPeopleDetailsState {}

class PopularPeopleDetailsLoadingState extends PopularPeopleDetailsState {}

class PopularPeopleDetailsLoadedState extends PopularPeopleDetailsState {
  final PopularDetailsEntity details;

  PopularPeopleDetailsLoadedState({required this.details});

  @override
  List<Object?> get props => [details];
}

class PopularPeopleDetailsErrorState extends PopularPeopleDetailsState {
  final String errorMessage;

  PopularPeopleDetailsErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class ImageDownloadSuccessState extends PopularPeopleDetailsState {
  final String filePath;

  ImageDownloadSuccessState({required this.filePath});
}

class ImageDownloadErrorState extends PopularPeopleDetailsState {
  final String errorMessage;

  ImageDownloadErrorState({required this.errorMessage});
}
