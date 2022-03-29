import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/models/response.dart' as r;

import '../constants/constant.dart';

final CollectionReference<Map<String, dynamic>> dashboard = firestore.collection('dashboard');
final DocumentReference<Map<String, dynamic>> classRef = firestore.collection('dashboard').doc('class');

class ClassController extends GetxController {
  @override
  void onInit() {
    listenClass();
    super.onInit();
  }

  static ClassController instance = Get.find();

  Map<String, List<String>> classes = {};

  final name = TextEditingController();
  final section = TextEditingController();

  listenClass() {
    List<String> sections = [];
    dashboard.doc('class').snapshots().listen((event) {
      event.data()?.forEach((key, value) {
        sections = [];
        for (var element in value) {
          sections.add(element.toString());
        }
        // print("\x1B[2J\x1B[0;0H");
        // print(value);
        // print(sections);
        classes[key] = sections;
      });
    });
    print(classes);
  }

  addClass() {
    classes[name.text.removeAllWhitespace] = <String>[];
    return classRef.update(classes).then((value) => r.Response.success("Class added"));
  }

  addSection(String className, String section) {
    classes[className] = classes[className] ?? [];
    classes[className]!.add(section);
    return classRef.update(classes).then((value) => r.Response.success("Section added"));
  }
}

var classController = ClassController.instance;
