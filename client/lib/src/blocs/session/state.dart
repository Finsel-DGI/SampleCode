import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNotifier extends ChangeNotifier {
  final TextEditingController _identifications =
      TextEditingController(text: _dIDP);
  final TextEditingController _signatures = TextEditingController(text: _dSP);

  TextEditingController get identificationPayload => _identifications;
  TextEditingController get signaturePayload => _signatures;

  void manualRefresh() {
    notifyListeners();
  }
}

final app = ChangeNotifierProvider<AppNotifier>((ref) => AppNotifier());

String _dIDP =
    '# Identification in pasby demo\n\nCompanies using pasby in their services can add a text describing the intent of a flow. The text always follows the fixed heading "Information"';
String _dSP =
    '# Confirmation in pasby demo\n\nCompanies using pasby in their services can add a text describing the intent with a signature.';
