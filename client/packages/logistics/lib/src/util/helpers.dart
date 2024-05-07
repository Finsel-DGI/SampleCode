import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

int randomNumberBtwRange(int max) {
  Random random = Random();
  return random.nextInt(max);
}

Color getFontColorForBackground(Color background) {
  return (background.computeLuminance() > 0.179) ? Colors.black : Colors.white;
}

Future readJson(String asset) async {
  final String response = await rootBundle.loadString(asset);
  final data = await json.decode(response);
  return data;
}

int unixTimeStampNow() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

Size getScreenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

Future delayed({Duration? duration, int timeInSec = 2}) async {
  await Future.delayed(duration ?? Duration(seconds: timeInSec));
}
