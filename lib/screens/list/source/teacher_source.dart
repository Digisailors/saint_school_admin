import 'package:flutter/material.dart';
import '../../../models/teacher.dart';

class TeacherSource extends DataTableSource {
  final List<Teacher> teachers;
  final BuildContext context;

  TeacherSource(this.teachers, this.context);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= teachers.length) return null;
    final teacher = teachers[index];
    return DataRow.byIndex(cells: [
      DataCell(IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {},
      )),
      DataCell(IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          teacher.controller.delete();
        },
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => teachers.length;

  @override
  int get selectedRowCount => 0;
}
