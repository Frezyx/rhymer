import 'package:flutter/material.dart';

abstract interface class AnalyticsI {
  RouteObserver<ModalRoute<dynamic>> get observer;

  Future<void> log(String name);
}
