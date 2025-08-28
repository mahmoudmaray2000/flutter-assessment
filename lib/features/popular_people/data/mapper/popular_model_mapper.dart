

import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_data.dart';
import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_model.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity.dart';

extension PopularPeopleModelMapper on PopularPeopleModel {
  PopularPeopleEntity toPopularModelEntity() {
    return PopularPeopleEntity(
      adult: adult,
      gender: gender,
      id: id,
      knownForDepartment: knownForDepartment,
      name: name,
      originalName: originalName,
      popularity: popularity,
      profilePath: profilePath,
      knownFor: knownFor
          ?.map(
            (data) => PopularPeopleData(
              id: data.id,
              mediaType: data.mediaType,
              title: data.title,
              name: data.name,
              originalName: data.originalName,
              originalTitle: data.originalTitle,
              overview: data.overview,
              posterPath: data.posterPath,
              backdropPath: data.backdropPath,
              releaseDate: data.releaseDate,
              firstAirDate: data.firstAirDate,
              voteAverage: data.voteAverage,
              voteCount: data.voteCount,
            ),
          )
          .toList(),
    );
  }
}
