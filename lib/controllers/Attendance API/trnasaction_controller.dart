import 'package:get/get.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/controllers/attendance_controller.dart';
import 'package:school_app/models/Attendance/transaction.dart';

class TransactionController extends GetxController {
  static TransactionController instance = Get.find();

  @override
  void onInit() {
    // loadTransactions();
    super.onInit();
  }

  static Future<List<TransactionLog>> loadTransactions({DateTime? startTime, DateTime? endTime, String? empCode}) {
    List<TransactionLog> transactionLogs = [];
    var callable = functions.httpsCallable('getTransaction');
    var data = {
      'token': AttendanceController.token,
      'start_time': startTime?.toString().substring(0, 19),
      'end_time': endTime?.toString().substring(0, 19),
      'emp_code': empCode
    };
    return callable.call(data).then((response) {
      var value = response.data;
      if (value is List) {
        transactionLogs = value.map((e) => TransactionLog.fromJson(e)).toList();
      }
      return transactionLogs;
    });
  }
}
