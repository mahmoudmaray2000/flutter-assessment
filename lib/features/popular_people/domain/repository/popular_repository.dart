import 'package:dartz/dartz.dart';
import 'package:flutter_assessment/core/networking/network_exception.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_details_entity.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity_response.dart';

abstract class PopularRepository {
  Future<Either<NetworkException, PopularPeopleEntityResponse>>
  getPopularPeople({required int page});

  Future<Either<NetworkException, PopularDetailsEntity>> getPopularDetails({
    required int id,
  });
}
