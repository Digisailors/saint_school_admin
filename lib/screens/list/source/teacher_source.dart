import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/screens/Form/teacher_form.dart';
import '../../../models/teacher.dart';

class TeacherSource extends DataTableSource {
  final List<Teacher> teachers;
  final BuildContext context;

  TeacherSource(this.teachers, this.context);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= teachers.length) return null;
    final entity = teachers[index];
    int sNo = index + 1;
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(sNo.toString())),
      DataCell((entity.imageUrl ?? '').isEmpty
          ? const CircleAvatar(
              child: Text("IMG"),
            )
          : CircleAvatar(
              backgroundImage: NetworkImage(entity.imageUrl!),
            )),
      DataCell(Text(entity.name)),
      DataCell(Text(entity.icNumber)),
      DataCell(Text(entity.email ?? '')),
      DataCell(Text(entity.gender.name.toString().toUpperCase())),
      DataCell(Text((entity.addressLine1 ?? '') +
          " ," +
          (entity.addressLine2 ?? '') +
          " ," +
          (entity.city ?? ''))),
      DataCell(IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          entity.controller.delete();
        },
      )),
      DataCell(IconButton(
          onPressed: () {
            Get.to(() => TeacherForm(teacher: entity));
          },
          icon: const Icon(Icons.edit))),
    ]);
  }

  static List<DataColumn> getCoumns() {
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

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => teachers.length;

  @override
  int get selectedRowCount => 0;
}
