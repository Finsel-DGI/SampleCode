import 'dart:convert';

import 'flow_abstract.dart';

class FlowResponse extends PasbyFlow {
  final FlowData data;

  FlowResponse({
    required this.data,
  }) : super("");

  factory FlowResponse.fromRawJson(String str) =>
      FlowResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FlowResponse.fromJson(Map<String, dynamic> json) => FlowResponse(
        data: FlowData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class FlowData {
  final bool cancelled;
  final bool sessionPicked;
  final String user;
  final int iat;
  final int? signedAt;
  final String? signature;
  final String? username;
  final Claims? claims;

  FlowData({
    required this.cancelled,
    required this.sessionPicked,
    required this.user,
    required this.iat,
    required this.signedAt,
    required this.username,
    required this.signature,
    required this.claims,
  });

  factory FlowData.fromRawJson(String str) =>
      FlowData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FlowData.fromJson(Map<String, dynamic> json) => FlowData(
        cancelled: json["cancelled"],
        sessionPicked: json["sessionPicked"],
        user: json["user"],
        username: json["username"],
        iat: json["iat"],
        signedAt: json["signedAt"],
        signature: json["signature"],
        claims: json["claims"] == null ? null : Claims.fromJson(json["claims"]),
      );

  Map<String, dynamic> toJson() => {
        "cancelled": cancelled,
        "sessionPicked": sessionPicked,
        "user": user,
        "iat": iat,
        "username": username,
        "signedAt": signedAt,
        "signature": signature,
        "claims": claims?.toJson(),
      };
}

class Claims {
  final Naming? naming;

  Claims({
    this.naming,
  });

  factory Claims.fromRawJson(String str) => Claims.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Claims.fromJson(Map<String, dynamic> json) => Claims(
        naming: json["naming"] == null ? null : Naming.fromJson(json["naming"]),
      );

  Map<String, dynamic> toJson() => {
        "naming": naming?.toJson(),
      };
}


class Naming {
  final String? family;
  final String? given;

  Naming({
    this.family,
    this.given,
  });

  factory Naming.fromRawJson(String str) => Naming.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Naming.fromJson(Map<String, dynamic> json) => Naming(
        family: json["family"],
        given: json["given"],
      );

  String get name => '$given $family';

  Map<String, dynamic> toJson() => {
        "family": family,
        "given": given,
      };
}
