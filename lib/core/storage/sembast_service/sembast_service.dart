abstract class SembastService {
  Future<void> savePeoplePage({
    required int page,
    required List<Map<String, dynamic>> peopleJson,
  });
  
  Future<List<Map<String, dynamic>>> getAllPeople();
  Future<void> clearCache();
}
