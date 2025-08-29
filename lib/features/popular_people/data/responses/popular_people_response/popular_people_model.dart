
import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_data.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity.dart';

class PopularPeopleModel {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  List<PopularPeopleData>? knownFor;

  PopularPeopleModel({
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

  PopularPeopleModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    if (json['known_for'] != null) {
      knownFor = <PopularPeopleData>[];
      json['known_for'].forEach((v) {
        knownFor!.add(new PopularPeopleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['known_for_department'] = this.knownForDepartment;
    data['name'] = this.name;
    data['original_name'] = this.originalName;
    data['popularity'] = this.popularity;
    data['profile_path'] = this.profilePath;
    if (this.knownFor != null) {
      data['known_for'] = this.knownFor!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory PopularPeopleModel.fromEntity(PopularPeopleEntity entity) {
    return PopularPeopleModel(
      id: entity.id!,
      name: entity.name ?? '',
      knownFor: entity.knownFor ?? [],
      profilePath: entity.profilePath,
      knownForDepartment: entity.knownForDepartment,
      originalName: entity.originalName,
      gender: entity.gender,
      adult: entity.adult,
      popularity: entity.popularity,

    );
  }

}
