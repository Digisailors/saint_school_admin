import 'package:flutter/material.dart';
import 'package:school_app/controllers/crude_controller.dart';
import 'package:school_app/controllers/parent_controller.dart';
import 'package:school_app/controllers/student_controller.dart';
import 'package:school_app/controllers/teacher_controller.dart';
import 'package:school_app/models/biodata.dart';

class BioSource extends DataTableSource {
  final List<Bio> entities;
  final BuildContext context;

  BioSource(this.entities, this.context);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= entities.length) return null;
    var entity = entities[index];
    final crud object = getEntity(entity);

    return DataRow.byIndex(index: index, cells: [
      DataCell(IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          // controller.change();
        },
      )),
      const DataCell(CircleAvatar(
        child: Text("IMG"),
      )),
      DataCell(Text(entity.name)),
      DataCell(Text(entity.icNumber)),
      DataCell(Text(entity.email)),
      DataCell(Text(entity.gender.toString())),
      DataCell(Text(entity.address ?? '')),
      DataCell(IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          object.delete();
        },
      )),
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
      const DataColumn(label: Text('EDIT')),
      const DataColumn(label: Text('PROFILE')),
      const DataColumn(label: Text('NAME')),
      const DataColumn(label: Text('IC NUMBER')),
      const DataColumn(label: Text('EMAIL')),
      const DataColumn(label: Text('GENDER')),
      const DataColumn(label: Text('ADDRESS')),
      const DataColumn(label: Text('DELETE')),
    ];

    return columns;
  }
}
