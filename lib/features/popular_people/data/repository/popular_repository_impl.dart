import 'package:dartz/dartz.dart';
import 'package:flutter_assessment/core/networking/network_exception.dart';
import 'package:flutter_assessment/features/popular_people/data/data_source/remote/data_source_impl.dart';
import 'package:flutter_assessment/features/popular_people/data/data_source/local/data_source_local_impl.dart';
import 'package:flutter_assessment/features/popular_people/data/mapper/popular_details_mapper.dart';
import 'package:flutter_assessment/features/popular_people/data/mapper/popular_local_mapper.dart';
import 'package:flutter_assessment/features/popular_people/data/mapper/popular_response_mapper.dart';
import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_model.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_details_entity.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity_response.dart';
import 'package:flutter_assessment/features/popular_people/domain/repository/popular_repository.dart';

class PopularRepositoryImpl extends PopularRepository {
  final PopularDataSourceImpl _popularDataSourceImpl;
  final DataSourceLocalImpl _dataSourceLocalImpl;

  PopularRepositoryImpl({
    required PopularDataSourceImpl popularDataSourceImpl,
    required DataSourceLocalImpl dataSourceLocalImpl,
  }) : _popularDataSourceImpl = popularDataSourceImpl,
       _dataSourceLocalImpl = dataSourceLocalImpl;

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

  @override
  Future<Either<NetworkException, List<PopularPeopleEntity>>>
  getPopularPeopleLocal() async {
    try {
      final response = await _dataSourceLocalImpl.getPopularPeople();
      final people = response
          .map((data) => PopularPeopleModel.fromJson(data))
          .toList();
      final entityList = people
          .map((model) => model.formLocalToEntity())
          .toList();
      return Right(entityList);
    } catch (e) {
      print("Error: $e");
      return Left(NetworkException(message: 'Failed to load cached data'));
    }
  }

  @override
  Future<void> cachePopularPeople({
    required List<PopularPeopleEntity> people,
    required int page,
  }) {
    final peopleJson = people
        .map((entity) => PopularPeopleModel.fromEntity(entity).toJson())
        .toList();
    return _dataSourceLocalImpl.savePopularPeople(
      page: page,
      peopleJson: peopleJson,
    );
  }
}
