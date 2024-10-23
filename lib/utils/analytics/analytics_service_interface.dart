import 'package:flutter/material.dart';

abstract interface class AnalyticsI {
  RouteObserver<ModalRoute<dynamic>> get observer;

  void log(String name);
  void logScreenView(String screenName);
}
