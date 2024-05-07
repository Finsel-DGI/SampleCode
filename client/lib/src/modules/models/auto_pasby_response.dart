import 'dart:convert';

import 'flow_abstract.dart';

class AutoPasbyResponse extends PasbyFlow {
  final UriData data;

  AutoPasbyResponse({
    required this.data,
  }) : super(data.identifier);

  factory AutoPasbyResponse.fromRawJson(String str) => AutoPasbyResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AutoPasbyResponse.fromJson(Map<String, dynamic> json) => AutoPasbyResponse(
    data: UriData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class UriData {
  final String uri;
  final String identifier;

  UriData({
    required this.uri,
    required this.identifier,
  });

  factory UriData.fromRawJson(String str) => UriData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UriData.fromJson(Map<String, dynamic> json) => UriData(
    uri: json["uri"],
    identifier: json["identifier"],
  );

  Map<String, dynamic> toJson() => {
    "uri": uri,
    "identifier": identifier,
  };
}
