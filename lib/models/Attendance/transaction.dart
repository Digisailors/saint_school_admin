// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

Transaction transactionFromJson(String str) => Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
    required this.id,
    required this.empCode,
    required this.firstName,
    this.lastName,
    required this.department,
    required this.position,
    required this.punchTime,
    required this.punchState,
    required this.punchStateDisplay,
    required this.verifyType,
    this.verifyTypeDisplay,
    this.workCode,
    this.gpsLocation,
    this.areaAlias,
    this.terminalSn,
    this.temperature,
    this.terminalAlias,
    required this.uploadTime,
  });

  int id;
  String empCode;
  String firstName;
  String? lastName;
  String department;
  String position;
  DateTime punchTime;
  String punchState;
  String punchStateDisplay;
  int verifyType;
  String? verifyTypeDisplay;
  String? workCode;
  String? gpsLocation;
  dynamic areaAlias;
  String? terminalSn;
  int? temperature;
  dynamic terminalAlias;
  DateTime uploadTime;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        empCode: json["emp_code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        department: json["department"],
        position: json["position"],
        punchTime: DateTime.parse(json["punch_time"]),
        punchState: json["punch_state"],
        punchStateDisplay: json["punch_state_display"],
        verifyType: json["verify_type"],
        verifyTypeDisplay: json["verify_type_display"],
        workCode: json["work_code"],
        gpsLocation: json["gps_location"],
        areaAlias: json["area_alias"],
        terminalSn: json["terminal_sn"],
        temperature: json["temperature"],
        terminalAlias: json["terminal_alias"],
        uploadTime: DateTime.parse(json["upload_time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emp_code": empCode,
        "first_name": firstName,
        "last_name": lastName,
        "department": department,
        "position": position,
        "punch_time": punchTime.toIso8601String(),
        "punch_state": punchState,
        "punch_state_display": punchStateDisplay,
        "verify_type": verifyType,
        "verify_type_display": verifyTypeDisplay,
        "work_code": workCode,
        "gps_location": gpsLocation,
        "area_alias": areaAlias,
        "terminal_sn": terminalSn,
        "temperature": temperature,
        "terminal_alias": terminalAlias,
        "upload_time": uploadTime.toString(),
      };
}
