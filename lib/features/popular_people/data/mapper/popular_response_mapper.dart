import 'package:flutter_assessment/features/popular_people/data/mapper/popular_model_mapper.dart';
import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_response.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity_response.dart';

extension PopularPeopleResponseMapper on PopularPeopleResponse {
  PopularPeopleEntityResponse toEntity() {
    return PopularPeopleEntityResponse(
      page: page,
      results: results?.map((model) => model.toPopularModelEntity()).toList(),
      totalPages: totalPages,
      totalResults: totalResults,
    );
  }
}
