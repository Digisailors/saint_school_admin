import 'dart:async';
import 'dart:collection';

import 'package:get/get.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/models/queue.dart';
import 'package:text_to_speech/text_to_speech.dart';

class QueueController extends GetxController {
  static QueueController instance = Get.find();
  List<StudentQueue> queuedStudentsList = [];

  final Queue<StudentQueue> ttsQueue = Queue<StudentQueue>();
  int pivot = 0;
  Timer? timer;

  @override
  void onInit() {
    listenQueue();
    timer = startSpeaking();
    super.onInit();
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.onClose();
  }

  Timer startSpeaking() {
    TextToSpeech tts = TextToSpeech();
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (queuedStudentsList.isNotEmpty) {
        int pivot = timer.tick % queuedStudentsList.length;
        tts.speak(queuedStudentsList[pivot].name);
      }
    });
  }

  Map<String, String> countDown = {};

  listenQueue() {
    queue.orderBy("queuedTime").limit(15).snapshots().listen((event) {
      queuedStudentsList = event.docs.map((e) => StudentQueue.fromJson(e.data())).toList();
      for (var e in event.docChanges) {
        // if new document
        if (e.oldIndex == -1) {
          var student = StudentQueue.fromJson(e.doc.data()!);
          ttsQueue.addLast(student);
          countDown[student.icNumber] = "00:00";
          student.queuedTime = DateTime.now();
          student.queueStatus = QueueStatus.inQueue;
          e.doc.reference.update(student.toJson());
        }
      }
      update();
    });
  }
}

QueueController queueController = QueueController.instance;
