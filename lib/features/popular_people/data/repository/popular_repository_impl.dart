import 'package:dartz/dartz.dart';
import 'package:flutter_assessment/core/networking/network_exception.dart';
import 'package:flutter_assessment/features/popular_people/data/data_source/data_source_impl.dart';
import 'package:flutter_assessment/features/popular_people/data/mapper/popular_details_mapper.dart';
import 'package:flutter_assessment/features/popular_people/data/mapper/popular_response_mapper.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_details_entity.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity_response.dart';
import 'package:flutter_assessment/features/popular_people/domain/repository/popular_repository.dart';

class PopularRepositoryImpl extends PopularRepository {
  final PopularDataSourceImpl _popularDataSourceImpl;

  PopularRepositoryImpl({required PopularDataSourceImpl popularDataSourceImpl})
    : _popularDataSourceImpl = popularDataSourceImpl;

  @override
  Future<Either<NetworkException, PopularPeopleEntityResponse>>
  getPopularPeople({required int page}) async {
    final response = await _popularDataSourceImpl.getPopularPeople(page: page);
    if (response.success == true) {
      return Right(response.data.toEntity());
    } else {
      return Left(NetworkException(message: response.message));
    }
  }

  @override
  Future<Either<NetworkException, PopularDetailsEntity>> getPopularDetails({
    required int id,
  }) async {
    final response = await _popularDataSourceImpl.getPopularDetails(id: id);
    if (response.success == true) {
      return Right(response.data.toDetailsEntity());
    } else {
      return Left(NetworkException(message: response.message));
    }
  }
}
