import 'package:flutter_assessment/features/popular_people/data/responses/popular_details_response/popular_details_response.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_details_entity.dart';

extension PopularDetailsMapper on PopularDetailsResponse {
  PopularDetailsEntity toDetailsEntity() {
    return PopularDetailsEntity(
      adult: adult,
      biography: biography,
      birthday: birthday,
      deathday: deathday,
      gender: gender,
      homepage: homepage,
      id: id,
      imdbId: imdbId,
      knownForDepartment: knownForDepartment,
      name: name,
      placeOfBirth: placeOfBirth,
      popularity: popularity,
      profilePath: profilePath,
    );
  }
}
