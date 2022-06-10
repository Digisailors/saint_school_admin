import 'package:flutter/material.dart';
import '../../../models/student.dart';

class StudentSource extends DataTableSource {
  final List<Student> students;
  final BuildContext context;

  StudentSource(this.students, this.context);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= students.length) return null;
    final student = students[index];
    return DataRow.byIndex(cells: [
      DataCell(IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {},
      )),
      DataCell(IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          student.controller.delete();
        },
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => students.length;

  @override
  int get selectedRowCount => 0;
}
