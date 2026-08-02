import 'package:flutter/foundation.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker? connectionChecker;

  NetworkInfoImpl([this.connectionChecker]);

  @override
  Future<bool> get isConnected async {
    if (kIsWeb) {
      // ✅ Always return true for web, since socket lookup isn’t supported
      return true;
    }
    try {
      // ✅ Mobile/Desktop platforms
      return await connectionChecker?.hasConnection ?? true;
    } catch (_) {
      // fallback — if checker throws, assume connected
      return true;
    }
  }
}
