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
        pivot = timer.tick % queuedStudentsList.length;
        tts.speak(queuedStudentsList[pivot].name);
      }
    });
  }

  Map<String, String> countDown = {};

  listenQueue() {
    queue.orderBy("queuedTime").limit(15).snapshots().listen((event) {
      for (var e in event.docChanges) {
        // if new document
        if (e.oldIndex == -1) {
          var student = StudentQueue.fromJson(e.doc.data()!);
          ttsQueue.addLast(student);
          countDown[student.icNumber] = "00:00";
          student.queuedTime = DateTime.now();
          student.queueStatus = QueueStatus.inQueue;
          queuedStudentsList.add(student);
          e.doc.reference.update(student.toJson());
          pivot < (queuedStudentsList.length - 1) ? pivot++ : pivot;
          student.timer = Timer(const Duration(seconds: 60), () {
            e.doc.reference.delete();
          });
        }
        if (e.newIndex == -1) {
          var student = StudentQueue.fromJson(e.doc.data()!);
          queuedStudentsList.removeWhere((element) => element.icNumber == student.icNumber);
          pivot != 0 ? pivot-- : pivot;
        }
      }
      update();
    });
  }
}

QueueController queueController = QueueController.instance;
