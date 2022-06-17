import 'package:flutter/material.dart';
import 'package:school_app/constants/get_constants.dart';
import 'package:school_app/controllers/auth_controller.dart';
import 'package:school_app/controllers/crud_controller.dart';
import 'package:school_app/controllers/parent_controller.dart';
import 'package:school_app/controllers/student_controller.dart';
import 'package:school_app/controllers/teacher_controller.dart';
import 'package:school_app/models/biodata.dart';
import 'package:school_app/models/appointment.dart';

import '../../appointmentreschedule.dart';

class AppointmentSource extends DataTableSource {
  final BuildContext context;
  List<Appointment> appointments;



  AppointmentSource(
    this.appointments,
    this.context,
  );

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= appointments.length) return null;
    var appointment = appointments[index];
    // final CRUD object = getEntity(entity);
    int SiNo = index + 1;

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(SiNo.toString())),
      DataCell(CircleAvatar(
        child: Text("IMG"),
      )),
      DataCell(Text(appointment.raisedBy)),
      DataCell(Text(appointment.date)),
      DataCell(Text('10:00 AM-11:00 AM')),
      DataCell(Text(appointment.status == 1 ? 'Apporoved' : 'Not Approved')),
      DataCell(ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(

                  content: SizedBox(
                    width: isMobile(context)?getWidth(context)*0.80:getWidth(context)*0.30,

                      child: AppointmentPage())
                );
              });
        },
        child: Text('Reschedule'),
      )),
      DataCell(ElevatedButton(

        onPressed: () {


        },
        child: Text('Accept'),
      )),
      DataCell(IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {},
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => appointments.length;

  @override
  int get selectedRowCount => 0;

  getEntity(Bio entity) {
    switch (entity.entityType) {
      case EntityType.parent:
        return ParentController.parentsList
            .firstWhere((p0) => p0.icNumber == entity.icNumber)
            .controller;
      case EntityType.teacher:
        return TeacherController.teacherList
            .firstWhere((p0) => p0.icNumber == entity.icNumber)
            .controller;
      case EntityType.student:
        return StudentController.studentList
            .firstWhere((p0) => p0.icNumber == entity.icNumber)
            .controller;
      default:
    }
  }

  static List<DataColumn> getCoumns() {
    List<DataColumn> columns = [
      const DataColumn(label: Text('SINO')),
      const DataColumn(label: Text('PROFILE')),
      const DataColumn(label: Text('NAME')),
      const DataColumn(label: Text('DATE')),
      const DataColumn(label: Text('TIME')),
      const DataColumn(label: Text('STATUS')),
      const DataColumn(
          label: Center(
              child: SizedBox(
                  width: 110,
                  child: Text(
                    'RESCHEDULE',
                    textAlign: TextAlign.center,
                  )))),
      const DataColumn(
          label: SizedBox( child: Center(child: Text('APPROVAL')))),
      const DataColumn(label: Text('DELETE'))
    ];

    return columns;
  }
}
