import 'dart:async';

import 'package:get/get.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/models/_newStudent.dart';
import 'package:school_app/models/queue%20copy.dart';

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
    // printInfo(info: "Listening to queue");
    queue.orderBy("queuedTime").limit(15).snapshots().listen((event) {
      queuedStudentsList = event.docs.map((e) => StudentQueue.fromJson(e.data())).toList();
      // printInfo(info: "Loaded Queue..");
      // printInfo(info: "Doc changes count : ${event.docChanges.length}");
      for (var e in event.docChanges) {
        // printInfo(info: "old index : ${e.oldIndex}, new index : ${e.newIndex}, ");
        if (e.oldIndex == -1) {
          print("New data pushed");
          var student = StudentQueue.fromJson(e.doc.data()!);
          countDown[student.icNumber] = "00:00";
          student.queuedTime = DateTime.now();
          student.queueStatus = QueueStatus.inQueue;
          e.doc.reference.update(student.toJson());
          Timer.periodic(const Duration(seconds: 1), (timer) {
            // printInfo(info: "Seconds : ${timer.tick}, Name : ${student.name} ");
            countDown[student.icNumber] = "00:" + "${60 - timer.tick}".padLeft(2, '0');
            update();
            if (timer.tick == 60) {
              timer.cancel();
              // e.doc.reference.delete();
            }
          });
          if (queuedStudentsList.where((element) => element.icNumber == student.icNumber).isEmpty) {}
        }
        // printInfo(info: "Called Update");
      }
      update();
    });
  }
}

QueueController queueController = QueueController.instance;
