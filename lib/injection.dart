import 'package:dio/dio.dart';
import 'package:flutter_assessment/core/networking/network_service.dart';

import 'core/storage/sembast_service.dart';

class Injector {
  static Injector? _instance;
  static late Dio _dio;
  static late NetworkHandler _networkHandler;
  static late SembastService _dbService;

  Injector._();

  static Injector get instance {
    _instance ??= Injector._();
    return _instance!;
  }
  static Future<void> init() async {
    _dio = Dio();
    _networkHandler = NetworkHandler(_dio);
    _dbService = SembastService();
    await _dbService.init();
  }
  static Dio get dio => _dio;
  static NetworkHandler get networkHandler => _networkHandler;
  static SembastService get dbService => _dbService;
}