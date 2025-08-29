import 'package:dartz/dartz.dart';
import 'package:flutter_assessment/core/networking/network_exception.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity.dart';
import 'package:flutter_assessment/features/popular_people/domain/repository/popular_repository.dart';

class LocalPopularUseCase {
  final PopularRepository _popularRepository;

  LocalPopularUseCase({required PopularRepository popularRepository})
    : _popularRepository = popularRepository;

  Future<void> execute({
    required int page,
    required List<PopularPeopleEntity> people,
  }) async {
    await _popularRepository.cachePopularPeople(people: people, page: page);
  }

  Future<Either<NetworkException, List<PopularPeopleEntity>>> call() {
    return _popularRepository.getPopularPeopleLocal();
  }
}
