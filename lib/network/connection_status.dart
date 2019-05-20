import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class Connection {
  Function() onRefreshScreen;
  Connection({this.onRefreshScreen});

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isOffline = true;
  
  void startListen(){
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void dispose(){
    _connectivitySubscription.cancel();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity(bool mounted) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted)
      return

    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName;
        wifiName = await _connectivity.getWifiName();
        isOffline = (wifiName != null) ? false : true;
        break;
      case ConnectivityResult.mobile:
        isOffline = false;
        break;
      case ConnectivityResult.none:
        isOffline = true;
        break;
      default:
        isOffline = true;
        break;
    }
    print('Status is offline: $isOffline');
    onRefreshScreen();
  }
}