import 'package:dartz/dartz.dart';
import 'package:flutter_assessment/core/networking/network_exception.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_details_entity.dart';
import 'package:flutter_assessment/features/popular_people/domain/repository/popular_repository.dart';

class FetchPopularDetailsUseCase {
  final PopularRepository _popularRepository;

  FetchPopularDetailsUseCase({required PopularRepository popularRepository})
    : _popularRepository = popularRepository;

  Future<Either<NetworkException, PopularDetailsEntity>> call({
    required int id,
  }) async {
    return await _popularRepository.getPopularDetails(id: id);
  }
}
