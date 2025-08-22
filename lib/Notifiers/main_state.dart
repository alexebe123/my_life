import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ntp/ntp.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MainState extends ChangeNotifier {
  bool isInternetFuond = true;
  DateTime dateTimeNow = DateTime.now();
  Future<DateTime> getTimeNtp() async {
    try {
      DateTime dateTimeNowOld = dateTimeNow;
      dateTimeNow = await NTP.now();

      if ((dateTimeNow.microsecond - dateTimeNowOld.millisecond) > 5000) {
        notifyListeners();
      }

      return dateTimeNow;
    } catch (e) {
      rethrow;
    }
  }

  checkInternetConnection() async {
    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      isInternetFuond = false;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      isInternetFuond = true;
    } else {
      isInternetFuond = true;
    }
    notifyListeners();
    /*  try {
      connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        if (connectivityResult == ConnectivityResult.none) {
          isInternetFuond = true;
        } else {
          isInternetFuond = false;
        }
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        if (connectivityResult == ConnectivityResult.none) {
          isInternetFuond = true;
        } else {
          isInternetFuond = false;
        }
      } else if (connectivityResult == ConnectivityResult.none) {
        isInternetFuond = true;
      } else {
        isInternetFuond = false;
      }
      notifyListeners();
    } catch (e) {
      log(e.toString());
      isInternetFuond = false;
    }*/
  }

  String getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
