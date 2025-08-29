import 'package:equatable/equatable.dart';

abstract class PopularPeopleDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPopularPeopleDetailsEvent extends PopularPeopleDetailsEvent {
  final int personId;

  FetchPopularPeopleDetailsEvent({required this.personId});

  @override
  List<Object?> get props => [personId];
}


class DownloadImageEvent extends PopularPeopleDetailsEvent {
  final String imageUrl;
  DownloadImageEvent({required this.imageUrl});
  @override
  List<Object?> get props => [imageUrl];
}