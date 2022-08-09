import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/controllers/Attendance%20API/trnasaction_controller.dart';
import 'package:school_app/controllers/attendance_controller.dart';
import 'package:school_app/models/Attendance/transaction.dart';
import 'package:school_app/screens/Form/student_form.dart';
import 'package:school_app/screens/list/student_list.dart';
import '../../../models/biodata.dart';
import '../../../models/student.dart';

class StudentSource extends DataTableSource {
  final List<StudentTransaction> students;
  final BuildContext context;
  StudentSource(
    this.students,
    this.context,
  );

  final timeFormat = DateFormat.jm();

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= students.length) return null;
    final studentTransaction = students[index];
    final entity = studentTransaction.student;
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
      DataCell(Text(entity.gender.name.toString().toUpperCase())),
      DataCell(Text(studentTransaction.checkInStatus == null ? 'NO DATA' : timeFormat.format(studentTransaction.checkInTime!))),
      DataCell(Text(studentTransaction.checkOutStatus == null ? 'NO DATA' : timeFormat.format(studentTransaction.checkOutTime!))),
      DataCell(IconButton(
        icon: const Icon(Icons.calendar_month),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                int index = 0;
                return Dialog(
                    child: DefaultTabController(
                  length: 2,
                  child: FutureBuilder<List<TransactionLog>>(
                      future: TransactionController.loadTransactions(empCode: entity.icNumber),
                      builder: (context, AsyncSnapshot<List<TransactionLog>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
                          List<TransactionLog> cafeLogs = [];
                          List<TransactionLog> gateLogs = [];
                          if (snapshot.hasData) {
                            var allLogs = snapshot.data!;
                            for (var log in allLogs) {
                              if (log.areaAlias == 'CAFETERIA') {
                                cafeLogs.add(log);
                              } else {
                                gateLogs.add(log);
                              }
                            }
                          }
                          // Text(entity.icNumber),
                          //     Text(entity.name),
                          //     Text(entity.classDepartment.deptName),
                          //     Text(entity.sectionDepartment.deptName),
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: SizedBox(
                                  width: 400,
                                  child: Table(
                                    children: [
                                      TableRow(children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "IC Number",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            entity.icNumber,
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Name",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            entity.name,
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Class",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            entity.classDepartment.deptName,
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Section",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            entity.sectionDepartment.deptName,
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 400,
                                child: TabBar(labelColor: Colors.blue, automaticIndicatorColorAdjustment: true, tabs: [
                                  Tab(child: Text('GATE')),
                                  Tab(child: Text('CAFETERIA')),
                                ]),
                              ),
                              Expanded(
                                child: TabBarView(children: [
                                  AttendanceTable(logs: gateLogs, area: 'GATE'),
                                  AttendanceTable(logs: cafeLogs, area: 'CAFETERIA'),
                                ]),
                              ),
                            ],
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Attendance Data Could not be retreived. PLease try again"),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ));
              });
        },
      )),
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
      // const DataColumn(label: Text('EMAIL')),
      const DataColumn(label: Text('GENDER')),
      const DataColumn(label: Text('CHECK IN')),
      const DataColumn(label: Text('CHECK OUT')),
      const DataColumn(label: Text('ATTENDANCE REPORT')),
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

class AttendanceLogSource extends DataTableSource {
  final BuildContext context;
  final List<TransactionLog> logs;
  final String? area;

  AttendanceLogSource(this.context, this.logs, this.area);

  bool status(DateTime date) {
    var statrTime = DateTime(date.year, date.month, date.day, 9, 26);
    return statrTime.isAfter(date);
  }

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= logs.length) return null;
    final log = logs[index];

    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(log.punchTime.toString().substring(0, 10))),
      DataCell(Text(log.punchTime.toString().substring(10, 16))),
      DataCell(Text(log.punchStateDisplay.toString())),
      DataCell(Text(status(log.punchTime) ? "ON-TIME" : "LATE")),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => logs.length;

  @override
  int get selectedRowCount => 0;

  static List<DataColumn> getCoumns() {
    List<DataColumn> columns = [
      const DataColumn(label: Text('SINO')),
      const DataColumn(label: Text('DATE')),
      const DataColumn(label: Text('PUNCH TIME')),
      const DataColumn(label: Text('PUNCH STATE')),
      const DataColumn(label: Text('STATUS')),
    ];
    return columns;
  }
}

class AttendanceTable extends StatelessWidget {
  const AttendanceTable({Key? key, required this.logs, required this.area}) : super(key: key);

  final List<TransactionLog> logs;
  final String area;
  @override
  Widget build(BuildContext context) {
    var source = AttendanceLogSource(context, logs, area);
    return PaginatedDataTable(columns: AttendanceLogSource.getCoumns(), source: source);
  }
}
