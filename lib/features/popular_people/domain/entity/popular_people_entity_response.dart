import 'package:equatable/equatable.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity.dart';

class PopularPeopleEntityResponse extends Equatable {
  final int? page;
  final List<PopularPeopleEntity>? results;
  final int? totalPages;
  final int? totalResults;

  const PopularPeopleEntityResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}
