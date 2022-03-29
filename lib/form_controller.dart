import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/controllers/session_controller.dart';
import 'package:school_app/models/student.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'models/response.dart';

enum Provide { network, memory, logo }

class StudentFormController {
  final name = TextEditingController();
  final id = TextEditingController();
  final List<TextEditingController> carNumbers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final father = TextEditingController();
  final mother = TextEditingController();
  final contact = TextEditingController();
  final studentClass = TextEditingController();
  final section = TextEditingController();
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

  Future<Response> createUser() async {
    var snapshot = await students.doc(id.text).get();
    if (snapshot.exists) {
      var data = snapshot.data();
      return Response.error("ID is taken by another student ${data!['name']}");
    }
    if (fileData != null) {
      image = await uploadImage(fileData!, id.text);
    }
    return student.createUser().then((value) => session.loadStudents());
  }

  Future<Response> updateUser() async {
    if (fileData != null) {
      image = await uploadImage(fileData!, id.text);
    }
    return student.updateUser().then((value) => session.loadStudents());
  }

  Student get student => Student(
      name: name.text,
      id: id.text,
      carNumbers: carNumbers.map((e) => e.text).toList(),
      contact: contact.text,
      studentClass: studentClass.text,
      section: section.text,
      address: address.text,
      guardian: guardian.text,
      father: father.text,
      mother: mother.text,
      image: image);

  factory StudentFormController.fromStudent(Student student) {
    StudentFormController controller = StudentFormController();
    controller.name.text = student.name;
    controller.id.text = student.id;
    controller.image = student.image;
    controller.father.text = student.father ?? '';
    controller.mother.text = student.mother ?? '';
    controller.contact.text = student.contact;
    controller.studentClass.text = student.studentClass;
    controller.section.text = student.section ?? '';
    controller.address.text = student.address;
    controller.guardian.text = student.guardian ?? '';
    controller.carNumbers[0].text = student.carNumbers[0];
    controller.carNumbers[1].text = student.carNumbers[1];
    controller.carNumbers[2].text = student.carNumbers[2];
    return controller;
  }
}
