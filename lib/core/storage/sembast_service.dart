import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class SembastService {
  static final SembastService _instance = SembastService._internal();
  factory SembastService() => _instance;
  SembastService._internal();
  late Database _db;
  final _store = stringMapStoreFactory.store('people_store');

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final dbPath = join(dir.path, 'app_db.db');
    _db = await databaseFactoryIo.openDatabase(dbPath);
  }

  Future<void> savePeoplePage(int page, List<Map<String, dynamic>> peopleJson) async {
    final key = 'page_$page';
    await _store.record(key).put(_db, {'items': peopleJson, 'ts': DateTime.now().toIso8601String()});
    final merged = await getAllPeople();
    final mergedMap = { for (var p in merged) p['id'].toString() : p};
    for (var p in peopleJson) {
      mergedMap[p['id'].toString()] = p;
    }
    await _store.record('merged').put(_db, {'items': mergedMap.values.toList(), 'ts': DateTime.now().toIso8601String()});
  }

  Future<List<Map<String, dynamic>>> getPeoplePage(int page) async {
    final rec = await _store.record('page_$page').get(_db) as Map?;
    if (rec == null) return [];
    print("Cache hit for page $page");
    print("Cache timestamp: ${rec['ts']}");
    return List<Map<String, dynamic>>.from(rec['items'] as List);
  }

  Future<List<Map<String, dynamic>>> getAllPeople() async {
    final rec = await _store.record('merged').get(_db) as Map?;
    if (rec == null) return [];
    return List<Map<String, dynamic>>.from(rec['items'] as List);
  }

  Future<void> clearCache() async {
    await _store.record('merged').delete(_db);
    final records = await _store.find(_db);
    for (final r in records) {
      if (r.key.toString().startsWith('page_')) {
        await _store.record(r.key).delete(_db);
      }
    }
  }
}
