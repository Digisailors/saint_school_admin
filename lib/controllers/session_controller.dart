import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/form_controller.dart';
import 'package:school_app/models/student.dart';

class MySession extends GetxController {
  static MySession instance = Get.find();
  final PageController controller = PageController(initialPage: 0);
  int pageIndex = 0;
  int selectedIndex = 0;
  Student? student;
  List<Student> kids = [];

  final searchController = TextEditingController();

  @override
  onInit() {
    listenStudents();
    super.onInit();
  }

  listenStudents() {
    students.snapshots().listen((event) {
      loadStudents();
    });
  }

  loadStudents() {
    if (searchController.text.isEmpty) {
      students.orderBy('id').get().then((event) {
        kids = event.docs.map((e) => Student.fromJson(e.data())).toList();
        selectedIndex = 0;
        selectedStudent = kids[selectedIndex];
        update();
      });
    } else {
      students
          .where('search', arrayContains: searchController.text.toLowerCase())
          .get()
          .then((event) {
        kids = event.docs.map((e) => Student.fromJson(e.data())).toList();
        selectedIndex = 0;
        selectedStudent = kids[selectedIndex];
        update();
      });
    }
  }

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
