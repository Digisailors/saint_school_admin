import 'dart:async';

import 'package:get/get.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/models/queue.dart';

class QueueController extends GetxController {
  static QueueController instance = Get.find();
  List<StudentQueue> queuedStudentsList = [];

  @override
  void onInit() {
    listenQueue();
    super.onInit();
  }

  Map<String, String> countDown = {};

  listenQueue() {
    queue.orderBy("queuedTime").limit(15).snapshots().listen((event) {
      queuedStudentsList = event.docs.map((e) => StudentQueue.fromJson(e.data())).toList();
      for (var e in event.docChanges) {
        if (e.oldIndex == -1) {
          var student = StudentQueue.fromJson(e.doc.data()!);
          countDown[student.icNumber] = "00:00";
          student.queuedTime = DateTime.now();
          student.queueStatus = QueueStatus.inQueue;
          e.doc.reference.update(student.toJson());
          Timer.periodic(const Duration(seconds: 1), (timer) {
            countDown[student.icNumber] = "00:" + "${60 - timer.tick}".padLeft(2, '0');
            update();
            if (timer.tick == 60) {
              timer.cancel();
              // e.doc.reference.delete();
            }
          });
          if (queuedStudentsList.where((element) => element.icNumber == student.icNumber).isEmpty) {}
        }
      }
      update();
    });
  }
}

QueueController queueController = QueueController.instance;
