import 'package:flutter/material.dart';

mixin AppSharedState {
  final scaffoldKey = _appKey;
}

final GlobalKey<ScaffoldMessengerState> _appKey =
    GlobalKey<ScaffoldMessengerState>();
