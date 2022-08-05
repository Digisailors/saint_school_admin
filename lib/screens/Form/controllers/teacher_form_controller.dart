import 'package:flutter/material.dart';
import 'package:school_app/models/Attendance/department.dart';
import 'package:school_app/models/teacher.dart';
import 'package:school_app/screens/Form/controllers/bio_form_controller.dart';
import '../../../controllers/department_controller.dart';

class TeacherFormController with BioFormController {
  Department? className;
  Department? section;
  String? uid;

  @override
  clear() {
    className = null;
    section = null;
    uid = null;
    return super.clear();
  }

  TeacherFormController();

  get classItems {
    List<DropdownMenuItem<Department?>> items = departmentListController
        .getClasses()
        .map((e) => DropdownMenuItem<Department>(
              child: Text(e.deptName),
              value: e,
            ))
        .toList();
    items.add(const DropdownMenuItem(child: Text("None")));
    return items;
  }

  List<DropdownMenuItem<Department>> get sectionItems {
    if (className == null) {
      return <DropdownMenuItem<Department>>[];
    }
    return departmentListController
        .getSections(className!.id!)
        .map((e) =>
            DropdownMenuItem<Department>(child: Text(e.toString()), value: e))
        .toList();
  }

  factory TeacherFormController.fromTeacher(Teacher teacher) {
    var controller = TeacherFormController();
    controller.className =
        departmentListController.findDepartment(className: teacher.className!);
    controller.section = departmentListController.findDepartment(
        className: teacher.className!, sectionName: teacher.section);
    controller.uid = teacher.uid;
    controller.email.text = teacher.email ?? '';
    controller.gender = teacher.gender;
    controller.icNumber.text = teacher.icNumber;
    controller.name.text = teacher.name;
    controller.address.text = teacher.address ?? '';
    controller.addressLine1.text = teacher.addressLine1 ?? '';
    controller.addressLine2.text = teacher.addressLine2 ?? '';
    controller.city = teacher.city;
    controller.image = teacher.imageUrl ?? '';
    controller.lastName.text = teacher.lastName ?? '';
    controller.primaryPhone.text = teacher.primaryPhone ?? '';
    controller.secondaryPhone.text = teacher.secondaryPhone ?? '';
    controller.state = teacher.state;
    return controller;
  }

  Teacher get teacher => Teacher(
        empCode: empCode.text,
        className: className?.id.toString(),
        section: section?.id.toString(),
        uid: uid,
        email: email.text,
        gender: gender,
        icNumber: icNumber.text,
        name: name.text,
        address: address.text,
        addressLine1: addressLine1.text,
        addressLine2: addressLine2.text,
        city: city,
        imageUrl: image,
        lastName: lastName.text,
        primaryPhone: primaryPhone.text,
        secondaryPhone: secondaryPhone.text,
        state: state,
      );
}
