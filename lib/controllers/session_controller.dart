import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/form_controller.dart';
import 'package:school_app/models/student.dart';

final CollectionReference<Map<String, dynamic>> queue = firestore.collection('Queue');

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

  sortLocal() {
    if (sortBy == 'name') {
      kids.sort((a, b) => a.name.compareTo(b.name));
      selectedIndex = 0;
      selectedStudent = kids.first;
      update();
    }
    if (sortBy == 'id') {
      kids.sort((a, b) => a.id.compareTo(b.id));
      selectedIndex = 0;
      selectedStudent = kids.first;
      update();
    }
    if (sortBy == 'class') {
      kids.sort((a, b) => a.studentClass.compareTo(b.studentClass));
      selectedIndex = 0;
      selectedStudent = kids.first;
      update();
    }
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listenQueue() {
    return students.where("inQueue", isEqualTo: true).limit(3).orderBy('queuedTime', descending: false).snapshots().listen((event) {
      if (event.docs.isEmpty) {
        queuedStudents = [];
        update();
      } else if (event.docs.length < 2) {
        queuedStudents = event.docs.map((e) => Student.fromJson(e.data())).toList();
        update();
      }
    });
  }

  loadQueue() {
    students.where("inQueue", isEqualTo: true).limit(3).orderBy('queuedTime', descending: false).get().then((value) {
      if (value.docs.isEmpty) {
        queuedStudents = [];
      } else {
        queuedStudents = value.docs.map((e) => Student.fromJson(e.data())).toList();
      }
    });
    update();
  }

  loadStudents() {
    if (searchController.text.isEmpty) {
      students.orderBy(sortBy).get().then((event) {
        kids = event.docs.map((e) => Student.fromJson(e.data())).toList();
        selectedIndex = 0;
        selectedStudent = kids.isNotEmpty ? kids[selectedIndex] : null;
        update();
      });
    } else {
      students.orderBy(sortBy).where('search', arrayContains: searchController.text.toLowerCase()).get().then((event) {
        kids = event.docs.map((e) => Student.fromJson(e.data())).toList();
        selectedIndex = 0;
        selectedStudent = kids.isNotEmpty ? kids[selectedIndex] : null;
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
