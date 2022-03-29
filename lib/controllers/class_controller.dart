import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    dashboard.doc('class').snapshots().listen((event) {
      event.data()?.forEach((key, value) {
        classes[key] = value.map((e) => e.toString()).toList();
      });
    });
  }

  addClass() {
    classes[name.text.removeAllWhitespace] = <String>[];
    classRef.update(classes);
  }

  addSection(String className, String section) {
    classes[className] = classes[className] ?? [];
    classes[className]!.add(section);
    classRef.update(classes);
  }
}

var classController = ClassController.instance;
