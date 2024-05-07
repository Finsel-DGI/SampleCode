import 'dart:convert';

import 'flow_abstract.dart';

class SecureStartResponse extends PasbyFlow {
  final SecureStartData data;

  SecureStartResponse({
    required this.data,
  }) : super(data.identifier);

  factory SecureStartResponse.fromRawJson(String str) => SecureStartResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SecureStartResponse.fromJson(Map<String, dynamic> json) => SecureStartResponse(
    data: SecureStartData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class SecureStartData {
  final List<String> seeds;
  final String identifier;

  SecureStartData({
    required this.seeds,
    required this.identifier,
  });

  factory SecureStartData.fromRawJson(String str) => SecureStartData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SecureStartData.fromJson(Map<String, dynamic> json) => SecureStartData(
    seeds: List<String>.from(json["seeds"].map((x) => x)),
    identifier: json["identifier"],
  );

  Map<String, dynamic> toJson() => {
    "seeds": List<dynamic>.from(seeds.map((x) => x)),
    "identifier": identifier,
  };
}
