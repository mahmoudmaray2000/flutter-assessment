import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'sembast_service.dart';


class SembastServiceImpl implements SembastService {
  SembastServiceImpl._();
  static final SembastServiceImpl instance = SembastServiceImpl._();
  Database? _db;
  final StoreRef<String, Map<String, Object?>> _store =
  stringMapStoreFactory.store('people_store');

  static const _kItems = 'items';
  static const _kTs = 'ts';
  static const _kMerged = 'merged';

  static String _pageKey(int page) => 'page_$page';

  Future<Database> get _database async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final dbPath = join(dir.path, 'app_db.db');
    _db = await databaseFactoryIo.openDatabase(dbPath);
    return _db!;
  }

  @override
  Future<void> savePeoplePage({
    required int page,
    required List<Map<String, dynamic>> peopleJson,
  }) async {
    final db = await _database;
    final now = DateTime.now().toIso8601String();
    final pageKey = _pageKey(page);

    await db.transaction((txn) async {
      await _store.record(pageKey).put(txn, {
        _kItems: peopleJson,
        _kTs: now,
      });
      final mergedRaw = await _store.record(_kMerged).get(txn);
      final List mergedItems =
      mergedRaw is Map<String, Object?> ? (mergedRaw[_kItems] as List? ?? const []) : const [];

      final mergedList = mergedItems
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      final mapById = <String, Map<String, dynamic>>{
        for (final p in mergedList) (p['id'] ?? '').toString(): p,
      };
      for (final p in peopleJson) {
        final id = (p['id'] ?? '').toString();
        if (id.isNotEmpty) mapById[id] = p;
      }
      await _store.record(_kMerged).put(txn, {
        _kItems: mapById.values.toList(),
        _kTs: now,
      });
    });
  }


  @override
  Future<List<Map<String, dynamic>>> getAllPeople() async {
    final db = await _database;
    final rec = await _store.record(_kMerged).get(db);
    if (rec is! Map<String, Object?>) return [];
    final raw = rec[_kItems] as List? ?? const [];
    return raw
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  @override
  Future<void> clearCache() async {
    final db = await _database;
    await db.transaction((txn) async {
      await _store.record(_kMerged).delete(txn);
      final records = await _store.find(txn);
      for (final r in records) {
        if (r.key.startsWith('page_')) {
          await _store.record(r.key).delete(txn);
        }
      }
    });
  }
}
