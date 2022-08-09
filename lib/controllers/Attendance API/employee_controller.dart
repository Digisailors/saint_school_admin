import 'package:school_app/constants/constant.dart';
import 'package:school_app/controllers/attendance_controller.dart';
import 'package:school_app/models/Attendance/employee.dart';

class EmployeeController {
  static Future<Employee> addEmployee(Employee employee) async {
    var callable = functions.httpsCallable('addEmployee');
    var data = employee.toJson();
    data.addAll({'token': AttendanceController.token});
    return callable.call(data).then((response) {
      var value = response.data;
      var employee = Employee.fromJson(value);
      return employee;
    });
  }

  static Future<Employee> updateEmployee(Employee employee) async {
    var callable = functions.httpsCallable('updateEmployee');
    var data = employee.toJson();
    data.addAll({'token': AttendanceController.token});
    return callable.call(data).then((response) {
      var value = response.data;
      var employee = Employee.fromJson(value);
      return employee;
    });
  }
}
