import 'package:dartz/dartz.dart';
import 'package:flutter_assessment/core/networking/network_exception.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity_response.dart';
import 'package:flutter_assessment/features/popular_people/domain/repository/popular_repository.dart';

class FetchPopularUseCase {
  final PopularRepository _popularRepository;

  FetchPopularUseCase({required PopularRepository popularRepository})
    : _popularRepository = popularRepository;

  Future<Either<NetworkException, PopularPeopleEntityResponse>> call({
    required int page,
  }) async {
    return await _popularRepository.getPopularPeople(page: page);
  }
}
