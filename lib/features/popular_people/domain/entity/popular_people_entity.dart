import 'package:equatable/equatable.dart';
import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_data.dart';

class PopularPeopleEntity extends Equatable {
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final List<PopularPeopleData>? knownFor;

  const PopularPeopleEntity({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.knownFor,
  });

  @override
  List<Object?> get props => [
    adult,
    gender,
    id,
    knownForDepartment,
    name,
    originalName,
    popularity,
    profilePath,
    knownFor,
  ];
}
