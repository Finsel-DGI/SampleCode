import 'dart:convert';

import 'flow_abstract.dart';

class DifferentDeviceFlowResponse extends PasbyFlow {
  final PasbyDiffData data;

  DifferentDeviceFlowResponse({
    required this.data,
  }) : super(data.identifier);

  factory DifferentDeviceFlowResponse.fromRawJson(String str) => DifferentDeviceFlowResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DifferentDeviceFlowResponse.fromJson(Map<String, dynamic> json) => DifferentDeviceFlowResponse(
    data: PasbyDiffData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class PasbyDiffData {
  final String identifier;

  PasbyDiffData({
    required this.identifier,
  });

  factory PasbyDiffData.fromRawJson(String str) => PasbyDiffData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PasbyDiffData.fromJson(Map<String, dynamic> json) => PasbyDiffData(
    identifier: json["identifier"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
  };
}
