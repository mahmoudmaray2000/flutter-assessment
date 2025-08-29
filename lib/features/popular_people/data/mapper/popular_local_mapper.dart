import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_model.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity.dart';

extension PopularLocaleMapper on PopularPeopleModel {
  PopularPeopleEntity formLocalToEntity() {
    return PopularPeopleEntity(
      id: id ?? 0,
      name: name ?? '',
      profilePath: profilePath ?? '',
      knownFor: knownFor ?? [],
      knownForDepartment: knownForDepartment,
      originalName: originalName,
      gender: gender,
      adult: adult,
      popularity: popularity,
    );
  }
}
