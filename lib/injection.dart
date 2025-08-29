import 'package:dio/dio.dart';
import 'package:flutter_assessment/core/connection/check_connection.dart';
import 'package:flutter_assessment/core/networking/network_service.dart';
import 'package:flutter_assessment/core/storage/sembast_service/sembast_service.dart';
import 'package:flutter_assessment/core/storage/sembast_service/sembast_service_impl.dart';



class Injector {
  Injector._();
  static final Injector _instance = Injector._();
  static Injector get instance => _instance;

  static late final Dio _dio;
  static late final NetworkHandler _networkHandler;
  static late final SembastService _dbService;
  static late final ConnectionService _connectionService;

  static Future<void> init() async {
    _dio = Dio();
    _connectionService = ConnectionService();
    _networkHandler = NetworkHandler(_dio);
    _dbService = SembastServiceImpl.instance;
  }

  static Dio get dio => _dio;
  static NetworkHandler get networkHandler => _networkHandler;
  static SembastService get dbService => _dbService;
  static ConnectionService get connectionService => _connectionService;
}
