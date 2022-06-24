import 'package:flutter/material.dart';
import 'package:school_app/constants/get_constants.dart';
import 'package:school_app/controllers/appointment_controller.dart';
import 'package:school_app/models/appointment.dart';

import '../../Form/appointment_form.dart';

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
      DataCell(Text(appointment.purpose)),
      // DataCell(Text(appointment.raisedBy ?? '')),
      DataCell(Text(appointment.date.toString())),
      DataCell(Text(appointment.fromTime.format(context) + " : " + appointment.toTime.format(context))),

      DataCell(Text(appointment.parentApproval ? "Accepted" : "Pending")),
      DataCell(
        appointment.adminApproval
            ? const Text("Accepted")
            : ElevatedButton(
                onPressed: () {
                  appointment.adminApproval = true;
                  appointment.status =
                      (appointment.parentApproval && appointment.adminApproval) ? AppointmentStatus.approved : AppointmentStatus.pending;
                  appointment.approve();
                },
                child: const Text('Approve'),
              ),
      ),
      DataCell(Text(appointment.status.toString().split('.').last.toUpperCase())),
      DataCell(ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    content: SizedBox(
                        width: isMobile(context) ? getWidth(context) * 0.80 : getWidth(context) * 0.30,
                        child: AppointmentPage(
                          appointment: appointment,
                        )));
              });
        },
        child: const Text('Reschedule'),
      )),
      DataCell(IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          AppointmentController(appointment).delete();
        },
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => appointments.length;

  @override
  int get selectedRowCount => 0;

  static List<DataColumn> getCoumns() {
    List<DataColumn> columns = [
      const DataColumn(label: Text('SINO')),
      const DataColumn(label: Text('TITLE')),
      const DataColumn(label: Text('DATE')),
      const DataColumn(label: Text('TIME')),
      const DataColumn(label: SizedBox(child: Center(child: Text('PARENT APPROVAL')))),
      const DataColumn(label: SizedBox(child: Center(child: Text('ADMIN APPROVAL')))),
      const DataColumn(label: Text('STATUS')),
      const DataColumn(
          label: Center(
              child: SizedBox(
                  width: 110,
                  child: Text(
                    'RESCHEDULE',
                    textAlign: TextAlign.center,
                  )))),
      const DataColumn(label: Text('DELETE'))
    ];

    return columns;
  }
}
