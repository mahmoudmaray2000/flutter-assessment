import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionService {
  Future<bool> get isConnected async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
