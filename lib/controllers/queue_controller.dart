import 'dart:async';

import 'package:get/get.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/models/student.dart';

class QueueController extends GetxController {
  static QueueController instance = Get.find();
  List<Student> queuedStudents = [];

  @override
  void onInit() {
    listenQueue();
    super.onInit();
  }

  Map<String, String> countDown = {};

  listenQueue() {
    // printInfo(info: "Listening to queue");
    queue.orderBy("queuedTime").limit(3).snapshots().listen((event) {
      queuedStudents = event.docs.map((e) => Student.fromJson(e.data())).toList();
      // printInfo(info: "Loaded Queue..");
      // printInfo(info: "Doc changes count : ${event.docChanges.length}");
      for (var e in event.docChanges) {
        // printInfo(info: "old index : ${e.oldIndex}, new index : ${e.newIndex}, ");
        if (e.oldIndex == -1) {
          var student = Student.fromJson(e.doc.data()!);
          countDown[student.id] = "00:10";
          Timer.periodic(const Duration(seconds: 1), (timer) {
            // printInfo(info: "Seconds : ${timer.tick}, Name : ${student.name} ");
            countDown[student.id] = "00:" + "${10 - timer.tick}".padLeft(2, '0');
            update();
            if (timer.tick == 11) {
              timer.cancel();
              e.doc.reference.delete();
            }
          });
        }
        // printInfo(info: "Called Update");
      }
      update();
    });
  }
}

QueueController queueController = QueueController.instance;
