import 'dart:typed_data';

import 'package:get/get_utils/get_utils.dart';
import 'package:flutter/material.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/controllers/class_controller.dart';

import 'package:image_picker_web/image_picker_web.dart';
import 'package:school_app/controllers/student_controller.dart';
import 'package:school_app/models/biodata.dart';

import 'models/response.dart' as r;
import 'models/student.dart';

enum Provide { network, memory, logo }

class StudentFormController {
  final name = TextEditingController();
  final id = TextEditingController();

  final father = TextEditingController();
  final mother = TextEditingController();

  final contact = TextEditingController();
  final studentClass = TextEditingController();
  final section = TextEditingController();
  String? classField;
  String? sectionField;

  Gender gender = Gender.male;

  final address = TextEditingController();
  final guardian = TextEditingController();
  String? image;

  StudentFormController();

  Provide show = Provide.logo;
  ImageProvider getAvatar() {
    if (fileData != null) {
      return MemoryImage(fileData!);
    } else if (image != null) {
      return NetworkImage(image!);
    } else {
      return const AssetImage('assets/logo.png');
    }
  }

  Uint8List? fileData;

  Future<void> imagePicker() async {
    var mediaInfo = await ImagePickerWeb.getImageInfo;
    if (mediaInfo!.data != null && mediaInfo.fileName != null) {
      fileData = mediaInfo.data;
      show = Provide.memory;
    }
    return;
  }

  get classItems => classController.classes.keys
      .map((e) => DropdownMenuItem(
            child: Text(e.toString()),
            value: e.toString(),
          ))
      .toList();

  List<DropdownMenuItem<String>> get sectionItems {
    if (classField == null) {
      return <DropdownMenuItem<String>>[];
    }
    return classController.classes[classField]!.map((e) => DropdownMenuItem(child: Text(e.toString()), value: e.toString())).toList();
  }

  clear() {
    name.clear();
    id.clear();

    father.clear();
    mother.clear();
    contact.clear();
    address.clear();
    classField = null;
    sectionField = null;
    image = null;
    fileData = null;
    gender = Gender.male;
  }

  Future<r.Result> createUser() async {
    var snapshot = await students.doc(id.text.toUpperCase().removeAllWhitespace).get();
    if (snapshot.exists) {
      var data = snapshot.data();
      return r.Result.error("ID is taken by another student ${data!['name']}");
    }
    if (fileData != null) {
      image = await uploadImage(fileData!, id.text.toUpperCase().removeAllWhitespace);
    }

    var controller = StudentController(student);

    return controller.add().then((value) {
      clear();
      return value;
    });
  }

  Future<r.Result> updateUser() async {
    if (StudentController.selectedStudent == null) {
      return r.Result.error("Please select a student");
    }
    if (fileData != null) {
      image = await uploadImage(fileData!, id.text);
    }
    var controller = StudentController(student);
    return controller.change().then((value) {
      // session.loadStudents();
      return value;
    });
  }

  Student get student => Student(
        name: name.text,
        icNumber: id.text.toUpperCase().removeAllWhitespace,
        email: contact.text,
        studentClass: classField!,
        section: sectionField!,
        address: address.text,
        parent: [],
        siblings: [],
        gender: gender,
      );

  factory StudentFormController.fromStudent(Student student) {
    StudentFormController controller = StudentFormController();
    controller.name.text = student.name;
    controller.id.text = student.icNumber;
    controller.image = student.imageUrl;

    controller.studentClass.text = student.studentClass;
    controller.section.text = student.section;
    controller.classField = student.studentClass;
    controller.sectionField = student.section;

    controller.gender = student.gender;

    return controller;
  }
}
