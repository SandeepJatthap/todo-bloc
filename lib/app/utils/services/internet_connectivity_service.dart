import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatusSingleton {
  ConnectionStatusSingleton._internal();

  static final ConnectionStatusSingleton _instance =
      ConnectionStatusSingleton._internal();

  static ConnectionStatusSingleton get instance => _instance;

  bool hasConnection = false;
  bool isInitial = true;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  bool isDialogOpen = false;

  void initialize() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    controller.sink.add(hasConnection);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  Future<bool> getConnectionStatus() async {
    return _checkStatus(await connectivity.checkConnectivity());
  }

  Future<bool> _checkStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      hasConnection = false;
      controller.sink.add(hasConnection);
      return hasConnection;
    }

    bool previousConnection = hasConnection;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }
    if (previousConnection != hasConnection || isInitial) {
      isInitial = false;
      controller.sink.add(hasConnection);
    }
    return hasConnection;
  }

  void disposeStream() => controller.close();
}
