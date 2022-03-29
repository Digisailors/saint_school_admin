import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/form_controller.dart';
import 'package:school_app/models/student.dart';

final CollectionReference<Map<String, dynamic>> queue =
    firestore.collection('Queue');

class MySession extends GetxController {
  static MySession instance = Get.find();
  final PageController controller = PageController(initialPage: 0);
  int pageIndex = 0;
  int selectedIndex = 0;
  Student? student;
  List<Student> kids = [];
  bool showFilter = true;
  String sortBy = 'id';

  List<DropdownMenuItem<String?>> getOrderByItems() {
    List<DropdownMenuItem<String?>> items = [];

    items.add(const DropdownMenuItem(
      child: Text("ID"),
      value: 'id',
    ));
    items.add(const DropdownMenuItem(
      child: Text("NAME"),
      value: 'name',
    ));
    items.add(const DropdownMenuItem(
      child: Text("CLASS"),
      value: 'class',
    ));
    return items;
  }

  List<Student> queuedStudents = [];

  final searchController = TextEditingController();

  @override
  onInit() {
    loadStudents();
    super.onInit();
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listenQueue() {
    return students
        .where("inQueue", isEqualTo: true)
        .limit(3)
        .snapshots()
        .listen((event) {
      if (event.docs.isEmpty) {
        queuedStudents = [];
        update();
      } else {
        queuedStudents =
            event.docs.map((e) => Student.fromJson(e.data())).toList();
        update();
      }

      for (var e in event.docs) {
        // Timer(const Duration(seconds: 30), () {
        //   e.reference.update({"inQueue": false});
        // });
      }
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
