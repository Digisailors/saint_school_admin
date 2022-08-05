import 'dart:async';
import 'package:school_app/models/Attendance/department.dart';

import 'student.dart';

class StudentQueue {
  Student student;
  QueueStatus queueStatus;
  DateTime? queuedTime;
  StudentQueue({
    required this.student,
    required this.queuedTime,
    this.queueStatus = QueueStatus.waiting,
  });

  Timer? timer;

  String get name => student.name;
  String get icNumber => student.icNumber;
  Department get studentClass => student.classDepartment;
  Department get section => student.sectionDepartment;
  int? get remaingTime => queuedTime == null
      ? 0
      : 10 - DateTime.now().difference(queuedTime!).inSeconds;

  factory StudentQueue.fromJson(json) => StudentQueue(
        student: Student.fromJson(json["student"]),
        queuedTime: json["queuedTime"]?.toDate(),
        queueStatus: QueueStatus.values.elementAt(json["queueStatus"]),
      );

  Map<String, dynamic> toJson() => {
        "student": student.toJson(),
        "queuedTime": queuedTime,
        "queueStatus": queueStatus.index,
      };
}

enum QueueStatus { waiting, inQueue }
