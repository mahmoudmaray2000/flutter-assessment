import 'package:flutter_assessment/core/storage/sembast_service.dart';

class DataSourceLocalImpl {
  final SembastService _dbService;

  DataSourceLocalImpl({required SembastService dbService}) : _dbService = dbService;

  Future<List<Map<String, dynamic>>> getPopularPeople() async {
    return await _dbService.getAllPeople();
  }

  Future<void> savePopularPeople({
    required int page,
    required List<Map<String, dynamic>> peopleJson,
  }) async {
    await _dbService.savePeoplePage(page, peopleJson);
  }
}
