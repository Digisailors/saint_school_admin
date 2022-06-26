import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/controllers/crud_controller.dart';
import 'package:school_app/controllers/parent_controller.dart';
import 'package:school_app/controllers/student_controller.dart';
import 'package:school_app/controllers/teacher_controller.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/models/parent.dart';
import 'package:school_app/models/student.dart';
import 'package:school_app/models/teacher.dart';
import 'package:school_app/screens/Form/parent_form.dart';
import 'package:school_app/screens/Form/student_form.dart';
import 'package:school_app/screens/Form/teacher_form.dart';

class BioSource extends DataTableSource {
  final List<dynamic> entities;
  final BuildContext context;

  BioSource(this.entities, this.context);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= entities.length) return null;
    Bio entity = entities[index];

    final CRUD object = getEntity(entity);
    int SiNo = index + 1;

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(SiNo.toString())),
      DataCell(CircleAvatar(
        child: (entity.imageUrl ?? '').isNotEmpty ? Image.network(entity.imageUrl!) : const Text("IMG"),
      )),
      DataCell(Text(entity.name)),
      DataCell(Text(entity.icNumber)),
      DataCell(Text(entity.email)),
      DataCell(Text(entity.gender.name.toString().toUpperCase())),
      DataCell(Text(entity.address ?? '')),
      DataCell(IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          object.delete();
        },
      )),
      DataCell(IconButton(
          onPressed: () {
            switch (entity.entityType) {
              case EntityType.student:
                Student student = entities[index];
                print(student.toJson());
                Get.to(() => StudentForm(student: student));
                break;
              case EntityType.teacher:
                Teacher teacher = entities[index];
                Get.to(() => TeacherForm(teacher: teacher));
                break;
              case EntityType.parent:
                Parent parent = entities[index];
                print(parent.toJson());
                Get.to(() => ParentForm(parent: parent));
                break;
              case EntityType.admin:
                // TODO: Handle this case.
                break;
            }
          },
          icon: const Icon(Icons.edit))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => entities.length;

  @override
  int get selectedRowCount => 0;

  getEntity(Bio entity) {
    switch (entity.entityType) {
      case EntityType.parent:
        return ParentController.parentsList.firstWhere((p0) => p0.icNumber == entity.icNumber).controller;
      case EntityType.teacher:
        return TeacherController.teacherList.firstWhere((p0) => p0.icNumber == entity.icNumber).controller;
      case EntityType.student:
        return StudentController.studentList.firstWhere((p0) => p0.icNumber == entity.icNumber).controller;
      default:
    }
  }

  static List<DataColumn> getCoumns(EntityType entity) {
    List<DataColumn> columns = [
      const DataColumn(label: Text('SINO')),
      const DataColumn(label: Text('PROFILE')),
      const DataColumn(label: Text('NAME')),
      const DataColumn(label: Text('IC NUMBER')),
      const DataColumn(label: Text('EMAIL')),
      const DataColumn(label: Text('GENDER')),
      const DataColumn(label: Text('ADDRESS')),
      const DataColumn(label: Text('DELETE')),
      const DataColumn(label: Text('EDIT')),
    ];

    return columns;
  }
}
