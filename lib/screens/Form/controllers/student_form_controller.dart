import 'package:get/get_utils/get_utils.dart';
import 'package:flutter/material.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/controllers/class_controller.dart';
import 'package:school_app/controllers/student_controller.dart';
import 'package:school_app/screens/Form/controllers/bio_form_controller.dart';

import '../../../models/response.dart' as r;
import '../../../models/student.dart';

class StudentFormController with BioFormController {
  final father = TextEditingController();
  final mother = TextEditingController();
  final studentClass = TextEditingController();
  final section = TextEditingController();
  final guardian = TextEditingController();
  String? classField;
  String? sectionField;
  final List<TextEditingController> siblings = [TextEditingController()];

  StudentFormController();

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

  List<DropdownMenuItem<String>> getSectionItems(String? className) {
    if (className == null) {
      return <DropdownMenuItem<String>>[];
    }
    return classController.classes[className]!.map((e) => DropdownMenuItem(child: Text(e.toString()), value: e.toString())).toList();
  }

  @override
  clear() {
    super.clear();
    siblings.clear();
    father.clear();
    mother.clear();
    studentClass.clear();
    section.clear();
    guardian.clear();
  }

  Future<r.Result> createUser() async {
    var snapshot = await students.doc(icNumber.text.toUpperCase().removeAllWhitespace).get();
    if (snapshot.exists) {
      var data = snapshot.data();
      return r.Result.error("ID is taken by another student ${data!['name']}");
    }
    if (fileData != null) {
      image = await uploadImage(fileData!, icNumber.text.toUpperCase().removeAllWhitespace);
    }

    var controller = StudentController(student);

    return controller.add().then((value) {
      clear();
      return value;
    });
  }

  Future<r.Result> updateUser({bool nameCheck = false}) async {
    if (fileData != null) {
      image = await uploadImage(fileData!, icNumber.text);
    }
    if (nameCheck) {
      var snapshot = await students.doc(icNumber.text.toUpperCase().removeAllWhitespace).get();
      if (snapshot.exists) {
        var data = snapshot.data();
        return r.Result.error("ID is taken by another student ${data!['name']}");
      }
    }
    var controller = StudentController(student);
    return controller.change().then((value) {
      // session.loadStudents();
      return value;
    });
  }

  Student get student => Student(
        name: name.text,
        icNumber: icNumber.text.toUpperCase().removeAllWhitespace,
        email: email.text,
        studentClass: classField!,
        imageUrl: image,
        addressLine1: addressLine1.text,
        addressLine2: addressLine2.text,
        city: city.text,
        primaryPhone: primaryPhone.text,
        secondaryPhone: secondaryPhone.text,
        section: sectionField!,
        address: addressLine1.text,
        siblings: siblings.map((e) => e.text).where((element) => element.isNotEmpty).toList(),
        gender: gender,
        father: father.text,
        guardian: guardian.text,
        mother: mother.text,
        state: state.text,
      );

  factory StudentFormController.fromStudent(Student student) {
    StudentFormController controller = StudentFormController();
    controller.name.text = student.name;
    controller.icNumber.text = student.icNumber;
    controller.image = student.imageUrl;
    controller.state.text = student.state ?? '';
    controller.studentClass.text = student.studentClass;
    controller.section.text = student.section;
    controller.classField = student.studentClass;
    controller.sectionField = student.section;
    controller.email.text = student.email;
    controller.addressLine1.text = student.addressLine1 ?? '';
    controller.addressLine2.text = student.addressLine2 ?? '';
    controller.city.text = student.city ?? '';
    controller.mother.text = student.mother ?? '';
    controller.father.text = student.father ?? '';
    controller.gender = student.gender;
    controller.primaryPhone.text = student.primaryPhone ?? '';
    controller.secondaryPhone.text = student.secondaryPhone ?? '';
    controller.siblings.clear();
    controller.siblings.addAll(student.siblings.map((e) => TextEditingController(text: e)));
    return controller;
  }
}
