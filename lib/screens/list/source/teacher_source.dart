import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/screens/Form/teacher_form.dart';
import 'package:school_app/screens/list/source/student_source.dart';
import '../../../controllers/Attendance API/trnasaction_controller.dart';
import '../../../models/Attendance/transaction.dart';
import '../../../models/teacher.dart';
import '../teacher_list.dart';

class TeacherSource extends DataTableSource {
  final List<TeacherTransaction> teachers;
  final BuildContext context;
  final StateSetter? setstate;
  TeacherSource(this.teachers, this.context, this.setstate);

  final timeFormat = DateFormat.jm();

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= teachers.length) return null;
    final teacherTransaction = teachers[index];
    final entity = teacherTransaction.teacher;
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
      DataCell(Text(teacherTransaction.checkInStatus == null ? 'NO DATA' : timeFormat.format(teacherTransaction.checkInTime!))),
      DataCell(Text(teacherTransaction.checkOutStatus == null ? 'NO DATA' : timeFormat.format(teacherTransaction.checkOutTime!))),
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
                      future: TransactionController.loadTransactions(empCode: entity.icNumber, entity: 1),
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
                                            entity.className ?? '',
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
                                            entity.section ?? '',
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
          entity.controller.delete().then((value) {
            if (setstate != null) {
              setstate!(() {
                teachers.remove(teacherTransaction);
              });
            }
          });
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
  int get rowCount => teachers.length;

  @override
  int get selectedRowCount => 0;
}
