

import 'package:flutter_assessment/core/networking/network_response.dart';
import 'package:flutter_assessment/core/networking/network_service.dart';
import 'package:flutter_assessment/features/popular_people/data/responses/popular_details_response/popular_details_response.dart';
import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_response.dart';

class PopularDataSourceImpl {
  final NetworkHandler _networkHandler;
  PopularDataSourceImpl({required NetworkHandler networkHandler}) : _networkHandler = networkHandler;

  Future<NetworkResponse<PopularPeopleResponse>> getPopularPeople({int page = 1}) async {
    final response = await _networkHandler.get<PopularPeopleResponse>(
      PopularPeopleResponse(),
      'https://api.themoviedb.org/3/person/popular',
      queryParameters: {
        'page': page,
        'language': 'en-US',
      },
    );
    return response;
  }


  Future<NetworkResponse<PopularDetailsResponse>> getPopularDetails({required int id}) async {
    final response = await _networkHandler.get<PopularDetailsResponse>(
      PopularDetailsResponse(),
      'https://api.themoviedb.org/3/person/$id',
      queryParameters: {
        'language': 'en-US',
      },
    );
    return response;
  }
}