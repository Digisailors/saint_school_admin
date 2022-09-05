// import 'package:flutter/foundation.dart';
import 'package:school_app/screens/list/student_list.dart';
import 'package:school_app/screens/list/teacher_list.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
// import 'dart:convert';
// import 'package:universal_html/html.dart' show AnchorElement;

class ExcelService {
  static Future<List<int>> createStudentsReport(List<StudentTransaction> studentTransactions) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('NAME');
    sheet.getRangeByName('B1').setText('IC NUMBER');
    sheet.getRangeByName('C1').setText('GENDER');
    sheet.getRangeByName('D1').setText('CHECK IN');
    sheet.getRangeByName('E1').setText('CHECK IN STATUS');
    sheet.getRangeByName('F1').setText('CHECK OUT');
    sheet.getRangeByName('G1').setText('CHECK OUT STATUS');

    for (int i = 0; i < studentTransactions.length; i++) {
      var studentTransaction = studentTransactions[i];
      sheet.getRangeByName('A${i + 2}').setText(studentTransaction.student.name.toUpperCase());
      sheet.getRangeByName('B${i + 2}').setText(studentTransaction.student.icNumber);
      sheet.getRangeByName('C${i + 2}').setText(studentTransaction.student.gender.toString().toUpperCase());
      sheet
          .getRangeByName('D${i + 2}')
          .setText(studentTransaction.checkInTime == null ? "NO DATA" : studentTransaction.checkInTime.toString().substring(0, 19));
      sheet
          .getRangeByName('E${i + 2}')
          .setText(studentTransaction.checkInStatus == null ? "NO DATA" : studentTransaction.checkInStatus.toString().toUpperCase());
      sheet
          .getRangeByName('F${i + 2}')
          .setText(studentTransaction.checkOutTime == null ? "NO DATA" : studentTransaction.checkOutTime.toString().substring(0, 19));
      sheet
          .getRangeByName('G${i + 2}')
          .setText(studentTransaction.checkOutStatus == null ? "NO DATA" : studentTransaction.checkOutStatus.toString().toUpperCase());
    }

    for (int i = 1; i <= 30; i++) {
      sheet.autoFitColumn(i);
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    // if (kIsWeb) {
    //   AnchorElement(href: 'data:application/octet-stream;charset=utf-16le;base64, ${base64.encode(bytes)}')
    //     ..setAttribute('download', 'export.xlsx')
    //     ..click();
    // }
    return bytes;
  }

  static Future<List<int>> createTeachersReport(List<TeacherTransaction> teacherTransactions) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('NAME');
    sheet.getRangeByName('B1').setText('IC NUMBER');
    sheet.getRangeByName('C1').setText('GENDER');
    sheet.getRangeByName('D1').setText('CHECK IN');
    sheet.getRangeByName('E1').setText('CHECK IN STATUS');
    sheet.getRangeByName('F1').setText('CHECK OUT');
    sheet.getRangeByName('G1').setText('CHECK OUT STATUS');

    for (int i = 0; i < teacherTransactions.length; i++) {
      var teacherTransaction = teacherTransactions[i];
      sheet.getRangeByName('A${i + 2}').setText(teacherTransaction.teacher.name.toUpperCase());
      sheet.getRangeByName('B${i + 2}').setText(teacherTransaction.teacher.icNumber);
      sheet.getRangeByName('C${i + 2}').setText(teacherTransaction.teacher.gender.toString().toUpperCase());
      sheet
          .getRangeByName('D${i + 2}')
          .setText(teacherTransaction.checkInTime == null ? "NO DATA" : teacherTransaction.checkInTime.toString().substring(0, 19));
      sheet
          .getRangeByName('E${i + 2}')
          .setText(teacherTransaction.checkInStatus == null ? "NO DATA" : teacherTransaction.checkInStatus.toString().toUpperCase());
      sheet
          .getRangeByName('F${i + 2}')
          .setText(teacherTransaction.checkOutTime == null ? "NO DATA" : teacherTransaction.checkOutTime.toString().substring(0, 19));
      sheet
          .getRangeByName('G${i + 2}')
          .setText(teacherTransaction.checkOutStatus == null ? "NO DATA" : teacherTransaction.checkOutStatus.toString().toUpperCase());
    }

    for (int i = 1; i <= 30; i++) {
      sheet.autoFitColumn(i);
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    // if (kIsWeb) {
    //   AnchorElement(href: 'data:application/octet-stream;charset=utf-16le;base64, ${base64.encode(bytes)}')
    //     ..setAttribute('download', 'export.xlsx')
    //     ..click();
    // }
    return bytes;
  }
}
