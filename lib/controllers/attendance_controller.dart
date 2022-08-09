// ignore_for_file: constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/constants/constant.dart';

import '../models/biodata.dart';

const USERNAME = 'govin';
const PASSWORD = 'Govin1040@';
const HOST = 'http://waxton.dvrdns.org:80';

class AttendanceController extends GetxController {
  static AttendanceController instance = Get.find();
  @override
  void onInit() {
    // getAuth();
    loadToken();
    super.onInit();
  }

  static String token = '';

  static sendRequest() {}

  static Future<void> loadToken() {
    var calable = functions.httpsCallable('loadToken');
    return calable.call().then((value) {
      token = value.data;
      print(token);
    });
  }

  static Future<void> getAuth() async {
    var url = '$HOST/jwt-api-token-auth/';
    var uri = Uri.parse(url);
    var headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {
      "username": USERNAME,
      "password": PASSWORD,
    };
    var response = await http.post(uri, headers: headers, body: jsonEncode(body));
    var responseBody = jsonDecode(response.body);
    token = responseBody['token'];
    return;
  }

  static const posistionMap = {
    EntityType.student: 16,
    EntityType.teacher: 17,
  };

  static const departmentMap = {
    EntityType.student: 265,
    EntityType.teacher: 266,
  };

  createEmployee(Bio bio) {
    var url = '$HOST/personnel/api/employees/';
    var uri = Uri.parse(url);
    var body = {
      "emp_code": bio.icNumber,
      "department": 1,
      "area": [20, 21],
      "position": posistionMap[bio.entityType],
    };
    uri.post(body: body).then((value) => print(jsonDecode(value.body)));
  }

  loadTodayAttendance() {}

  getTransactionReport(DateTime fromDate, DateTime toDate, EntityType entityType) {
    // var url = '$HOST/att/api/transactionReport/';
    var params = {
      'start_date': fromDate.toString().substring(0, 10),
      'end_date': toDate.toString().substring(0, 19),
      'departments': [265, 266],
    };
    var uri = Uri.https(HOST, '/att/api/transactionReport/', params);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': AttendanceController.token,
    };
    http.get(uri, headers: headers).then((value) => print(jsonDecode(value.body)));
  }
}

extension Raptor on Uri {
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Authorization': AttendanceController.token,
      };
  Future<http.Response> post({Map<String, dynamic>? body, Map<String, String>? additionalHeaders}) {
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }
    return http.post(this, headers: headers, body: jsonEncode(body));
  }
}

AttendanceController attendanceController = AttendanceController.instance;
