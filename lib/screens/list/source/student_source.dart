import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/screens/Form/student_form.dart';
import '../../../models/biodata.dart';
import '../../../models/student.dart';

class StudentSource extends DataTableSource {
  final List<Student> students;
  final BuildContext context;

  StudentSource(this.students, this.context);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= students.length) return null;
    final entity = students[index];
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
            Get.to(() => StudentForm(student: entity));
          },
          icon: const Icon(Icons.edit))),
    ]);
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

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => students.length;

  @override
  int get selectedRowCount => 0;
}
