import 'package:flutter_assessment/core/networking/network_mapper.dart';
import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_model.dart';

class PopularPeopleResponse extends BaseMappable {
  int? page;
  List<PopularPeopleModel>? results;
  int? totalPages;
  int? totalResults;

  PopularPeopleResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <PopularPeopleModel>[];
      json['results'].forEach((v) {
        results!.add(PopularPeopleModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    return PopularPeopleResponse(
      page: page,
      results: results,
      totalPages: totalPages,
      totalResults: totalResults,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}
