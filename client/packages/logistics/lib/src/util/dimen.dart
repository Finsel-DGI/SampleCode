import 'package:flutter/material.dart';

EdgeInsets padAll({double pad = 20}) => EdgeInsets.all(pad);
EdgeInsets padNone() => EdgeInsets.zero;
EdgeInsets padAsymmetric({double horiz = 25.0, double vert = 0.0}) =>
    EdgeInsets.symmetric(horizontal: horiz, vertical: vert);
