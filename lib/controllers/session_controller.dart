import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/form_controller.dart';
import 'package:school_app/models/student.dart';

class MySession extends GetxController {
  static MySession instance = Get.find();
  final PageController controller = PageController(initialPage: 0);
  int pageIndex = 0;
  int selectedIndex = 0;
  Student? student;

  set selectedStudent(Student? tempStudent) {
    student = tempStudent;
    loadForm();
  }

  StudentFormController formcontroller = StudentFormController();

  loadForm() {
    formcontroller = student?.formController ?? StudentFormController();
    update();
  }
}

MySession session = MySession.instance;
