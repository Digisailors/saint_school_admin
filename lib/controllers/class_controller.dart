import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';

final CollectionReference<Map<String, dynamic>> dashboard =
    firestore.collection('class');

class ClassController extends GetxController {
  @override
  void onInit() {
    listenClasses();
    super.onInit();
  }

  static ClassController instance = Get.find();

  Map<String, dynamic> classes = {};

  List<Map<String, dynamic>> sections = [];

  loadSections() {
    classes.forEach((key, value) {
      List<dynamic> sectionList = value;
      for (var element in sectionList) {
        sections.add({"name": key, "section": element});
      }
    });
  }

  listenClasses() {
    dashboard.doc('class').snapshots().listen((event) {
      classes = event.data() ?? classes;
      loadSections();
      update();
    });
  }

  List<DropdownMenuItem<String>> get classItems => classes.keys
      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
      .toList();

  List<DropdownMenuItem<String>>? getSectionItems(String key) {
    return classes[key]
        ?.map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList();
  }

  final name = TextEditingController();
  final section = TextEditingController();

  add() {
    classes[name.text.removeAllWhitespace]
        .add(section.text.removeAllWhitespace);
    dashboard.doc('class').update(classes);
  }
}

var classController = ClassController.instance;
